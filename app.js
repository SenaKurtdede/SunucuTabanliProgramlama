const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session');
const mysql = require('mysql2');

const app = express();
const port = 3000;


const db = mysql.createConnection({
    host: 'localhost',
    user: 'root', 
    password: '', 
    database: 'arcanus' 
});

// Veritabanına bağlan
db.connect((err) => {
    if (err) {
        console.error('Veritabanı bağlantı hatası:', err);
        process.exit(1);
    }
    console.log('Veritabanına başarıyla bağlanıldı!');
});

// Statik dosya servis ayarlarını güncelle
app.use(express.static(__dirname));
app.use(express.static(path.join(__dirname, 'public')));

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
    secret: 'your-secret-key', // Session şifresi
    resave: false,
    saveUninitialized: true
}));

// Giriş işlemi
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    // Veritabanında kullanıcı doğrulama
    const query = 'SELECT * FROM kullanicilar WHERE kullanici_adi = ? AND sifre = ?';
    db.query(query, [username, password], (err, results) => {
        if (err) {
            console.error('Sorgu hatası:', err);
            return res.status(500).send('Bir hata oluştu, lütfen tekrar deneyin.');
        }

        if (results.length > 0) {
            req.session.loggedIn = true; // Oturumu başlat
            return res.redirect('/dashboard'); // Başarılı giriş sonrası yönlendirme
        } else {
            return res.send('<h1>Giriş başarısız! Kullanıcı adı veya şifre yanlış.</h1>');
        }
    });
});

// Ana sayfa yönlendirmesi - güncellendi
app.get('/', (req, res) => {
    if (req.session.loggedIn) {
        res.redirect('/dashboard');
    } else {
        res.sendFile(path.join(__dirname, 'login.html'));
    }
});

// Oturum kontrolü middleware'i
const requireLogin = (req, res, next) => {
    if (req.session.loggedIn) {
        next();
    } else {
        res.redirect('/');
    }
};

// Dashboard route'u - güncellendi
app.get('/dashboard', requireLogin, (req, res) => {
    res.sendFile(path.join(__dirname, 'dashboard.html'));
});

// Hizmet Analizi route'u
app.get('/hizmet-analizi', requireLogin, (req, res) => {
    res.sendFile(path.join(__dirname, 'hizmetanalizi.html'));
});

// Odalar route'u - güncellendi
app.get('/odalar', requireLogin, (req, res) => {
    res.sendFile(path.join(__dirname, 'odalar.html'));
});

// Misafirler route'u
app.get('/misafirler', requireLogin, (req, res) => {
    res.sendFile(path.join(__dirname, 'misafirler.html'));
});

// Ay listesini getiren endpoint'i güncelle
app.get('/api/aylar/:tip', requireLogin, (req, res) => {
    const tip = req.params.tip;
    let query;
    
    if (tip === 'yas') {
        query = 'SELECT DISTINCT ay_id FROM yas ORDER BY ay_id';
    } else if (tip === 'misafir') {
        query = 'SELECT DISTINCT ay_id FROM misafir_analizi ORDER BY ay_id';
    } else {
        return res.status(400).json({ error: 'Geçersiz tip' });
    }

    db.query(query, (err, results) => {
        if (err) {
            console.error('Ay verileri sorgu hatası:', err);
            return res.status(500).json({ error: 'Veriler alınamadı' });
        }
        res.json(results);
    });
});

// Belirli bir aya göre misafir analizi verilerini getiren endpoint
app.get('/api/misafir_analizi/:ay', requireLogin, (req, res) => {
    const ay = req.params.ay;
    const query = `
        SELECT 
            irk_adi,
            irk_miktari 
        FROM misafir_analizi 
        WHERE ay_id = ?
        ORDER BY irk_miktari DESC`;

    db.query(query, [ay], (err, results) => {
        if (err) {
            console.error('Misafir analizi sorgu hatası:', err);
            return res.status(500).json({ error: 'Veriler alınamadı' });
        }
        res.json(results);
    });
});

// Yaş verilerini getiren endpoint
app.get('/api/yas-verileri/:ay', requireLogin, (req, res) => {
    const ay = req.params.ay;
    const query = `
        SELECT 
            ay_id,
            cocuk_sayisi,
            yetiskin_sayisi,
            (cocuk_sayisi * 100.0 / (cocuk_sayisi + yetiskin_sayisi)) as cocuk_orani,
            ((cocuk_sayisi + yetiskin_sayisi) / 2) as yas_ortalama
        FROM yas 
        WHERE ay_id = ?`;

    db.query(query, [ay], (err, results) => {
        if (err) {
            console.error('Yaş verileri sorgu hatası:', err);
            return res.status(500).json({ error: 'Veriler alınamadı' });
        }
        res.json(results);
    });
});

// Hizmet aylarını getiren endpoint
app.get('/api/hizmet-aylari', requireLogin, (req, res) => {
    const query = 'SELECT DISTINCT ay_id FROM hizmetler ORDER BY ay_id';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Hizmet ayları sorgu hatası:', err);
            return res.status(500).json({ error: 'Veriler alınamadı' });
        }
        res.json(results);
    });
});

// Belirli bir aya göre hizmet verilerini getiren endpoint
app.get('/api/hizmetler/:ay', requireLogin, (req, res) => {
    const ay = req.params.ay;
    const query = `
        SELECT 
            hizmet_adi,
            kullanim_sayisi
        FROM hizmetler 
        WHERE ay_id = ?
        ORDER BY kullanim_sayisi DESC`;

    db.query(query, [ay], (err, results) => {
        if (err) {
            console.error('Hizmet verileri sorgu hatası:', err);
            return res.status(500).json({ error: 'Veriler alınamadı' });
        }
        res.json(results);
    });
});
//----
// Oda tipi doluluk oranlarını getiren endpoint
app.get('/api/oda-doluluk', requireLogin, (req, res) => {
    const query = `
        SELECT 
            oda_tipi,
            doluluk_orani
        FROM oda_tipi_doluluk 
        ORDER BY oda_tipi`;

    db.query(query, (err, results) => {
        if (err) {
            console.error('Oda doluluk verileri sorgu hatası:', err);
            return res.status(500).json({ error: 'Veriler alınamadı' });
        }
        res.json(results);
    });
});

// Sezonsal doluluk oranlarını getiren endpoint
app.get('/api/sezonsal-doluluk', requireLogin, (req, res) => {
    const query = `
        SELECT 
            mevsim_adi,
            doluluk_orani
        FROM sezonsal_doluluk 
        ORDER BY 
            CASE mevsim_adi
                WHEN 'Kış' THEN 1
                WHEN 'İlkbahar' THEN 2
                WHEN 'Yaz' THEN 3
                WHEN 'Sonbahar' THEN 4
            END`;

    db.query(query, (err, results) => {
        if (err) {
            console.error('Sezonsal doluluk verileri sorgu hatası:', err);
            return res.status(500).json({ error: 'Veriler alınamadı' });
        }
        res.json(results);
    });
});

// Çıkış işlemi
app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/');
});

app.listen(port, () => {
    console.log(`Sunucu http://localhost:${port} adresinde çalışıyor`);
});
app.get('/api/gelir-analizi', (req, res) => {
    const query = 'SELECT ay_id, gelir_miktari FROM gelir ORDER BY ay_id';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Gelir analizi sorgu hatası:', err);
            return res.status(500).json({ error: 'Gelir verileri alınamadı.' });
        }
        res.json(results);
    });
});
app.post('/api/logout', (req, res) => {
    req.session.destroy(err => {
        if (err) {
            console.error('Oturum sonlandırılamadı:', err);
            return res.status(500).json({ error: 'Çıkış yapılamadı.' });
        }
        res.clearCookie('connect.sid'); // Oturum çerezini temizle
        res.status(200).send('Çıkış başarılı.');
    });
});
