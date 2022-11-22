module ChartsHelper

  def cardscore_by_status

    pie_chart cardscore_by_status_charts_path(deck_code: @deck.code), id: "result-chart", class: "result-chart", donut: true, colors: ["#F0C267", "rgba(0, 0, 0, 0.25)"], library: {
      animation: {
        duration: 500
      }, 
      elements: {
        arc: {
          borderWidth: 0,
          borderRadius: 10,
        }  
      },
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        },
      },
      datasets: {
        pie: {
          cutout: '80%'
        }
      },

    }

  end

end