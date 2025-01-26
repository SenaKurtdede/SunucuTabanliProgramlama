document.addEventListener('DOMContentLoaded', function() {
    
    const occupancyCtx = document.getElementById('occupancyChart').getContext('2d');
    new Chart(occupancyCtx, {
        type: 'line',
        data: {
            labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran'],
            datasets: [{
                label: 'Doluluk Oranı %',
                data: [61, 56, 66, 73, 80, 88],
                borderColor: '#1976d2',
                tension: 0.4,
                fill: true,
                backgroundColor: 'rgba(25, 118, 210, 0.1)'
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });

    
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'bar',
        data: {
            labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran'],
            datasets: [{
                label: 'Gelir (₺)',
                data: [42000, 45000, 48000, 50000, 52000, 52450],
                backgroundColor: '#388e3c',
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    
    const ageCtx = document.getElementById('ageAnalysisChart').getContext('2d');
    new Chart(ageCtx, {
        type: 'line',
        data: {
            labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran'],
            datasets: [{
                label: 'Yaş Ortalaması',
                data: [35, 38, 32, 28, 30, 25],
                borderColor: '#9c27b0',
                tension: 0.4,
                yAxisID: 'y'
            }, {
                label: 'Çocuk Oranı (%)',
                data: [15, 18, 25, 35, 40, 45],
                borderColor: '#ff9800',
                tension: 0.4,
                yAxisID: 'y1'
            }]
        },
        options: {
            responsive: true,
            interaction: {
                mode: 'index',
                intersect: false,
            },
            plugins: {
                legend: { position: 'top' }
            },
            scales: {
                y: {
                    type: 'linear',
                    position: 'left',
                    title: {
                        display: true,
                        text: 'Yaş Ortalaması'
                    }
                },
                y1: {
                    type: 'linear',
                    position: 'right',
                    title: {
                        display: true,
                        text: 'Çocuk Oranı (%)'
                    },
                    grid: {
                        drawOnChartArea: false
                    }
                }
            }
        }
    });

    
    const nationalityCtx = document.getElementById('nationalityChart').getContext('2d');
    new Chart(nationalityCtx, {
        type: 'bar',
        data: {
            labels: ['Türk', 'Alman', 'Rus', 'İngiliz', 'Arap'],
            datasets: [{
                label: 'Yaz Sezonu (%)',
                data: [30, 25, 20, 15, 10],
                backgroundColor: '#f44336'
            }, {
                label: 'Kış Sezonu (%)',
                data: [35, 15, 30, 10, 10],
                backgroundColor: '#2196f3'
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'top' }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Misafir Oranı (%)'
                    }
                }
            }
        }
    });

    
    function updateRecommendations() {
        const childRatio = 35; 
        const dominantNationality = 'Rus'; 

        const recommendationsList = document.getElementById('activityRecommendations');
        const suggestions = [];

        if (childRatio > 30) {
            suggestions.push('Çocuk aktivitelerinin arttırılması önerilir (Mini club, çocuk havuzu etkinlikleri)');
        }

        if (dominantNationality === 'Rus') {
            suggestions.push('Açık büfede Rus mutfağından örnekler sunulabilir');
            suggestions.push('Akşam eğlencelerinde Rus müziklerine yer verilebilir');
        }

        recommendationsList.innerHTML = suggestions.map(suggestion => 
            `<li><i class="fas fa-lightbulb"></i> ${suggestion}</li>`
        ).join('');
    }

    updateRecommendations();
});
document.addEventListener('DOMContentLoaded', function () {
    
    fetch('/api/gelir-analizi')
        .then(response => response.json())
        .then(data => {
            const labels = data.map(item => `Ay ${item.ay_id}`);
            const values = data.map(item => item.gelir_miktari);

            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            new Chart(revenueCtx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Gelir (₺)',
                        data: values,
                        backgroundColor: '#388e3c',
                        borderRadius: 5
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Gelir (₺)'
                            }
                        }
                    }
                }
            });
        })
        .catch(err => console.error('Gelir analizi yüklenirken hata oluştu:', err));
});
document.getElementById('logoutButton').addEventListener('click', function (event) {
    event.preventDefault(); 
    
    
    fetch('/api/logout', { method: 'POST' })
        .then(response => {
            if (response.ok) {
                
                window.location.href = '/login';
            } else {
                console.error('Çıkış yaparken bir hata oluştu.');
            }
        })
        .catch(err => console.error('Sunucuya ulaşılamadı:', err));
});

