# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  config =
    type: 'line'
    data:
      labels: []
      datasets: [
        {
          label: "Temperature"
          type: 'line'
          data: []
          fill: false
          backgroundColor: "rgba(255, 99, 132, 0.8)"
          borderColor: "rgba(255, 99, 132, 0.8)"
          yAxisID: "y-axis-temperature"
          lineTension: 0
          pointRadius: 0
          pointHitRadius: 10
        },
        {
          label: "Pressure"
          type: 'line'
          data: []
          fill: false
          backgroundColor: "rgba(54, 162, 235, 0.8)"
          borderColor: "rgba(54, 162, 235, 0.8)"
          yAxisID: "y-axis-pressure"
          lineTension: 0
          pointRadius: 0
          pointHitRadius: 10
        },
        {
          label:"Humidity"
          type: 'line'
          data: []
          fill: false
          backgroundColor: "rgba(255, 206, 86, 0.8)"
          borderColor: "rgba(255, 206, 86, 0.8)"
          yAxisID: "y-axis-humidity"
          lineTension: 0
          pointRadius: 0
          pointHitRadius: 10
        } ]
    options:
      animation: false
      scales:
        xAxes: [ {
          type: 'time'
          time: displayFormats:
            'millisecond': 'HH:mm:ss'
            'second': 'HH:mm:ss'
            'minute': 'HH:mm:ss'
            'hour': 'HH:mm:ss'
            'day': 'HH:mm:ss'
            'week': 'HH:mm:ss'
            'month': 'HH:mm:ss'
            'quarter': 'HH:mm:ss'
            'year': 'HH:mm'
        } ]
        yAxes: [ {
            position: "right"
            id: "y-axis-pressure"
            scaleType: "linear"
            # ticks: {
            #   suggestedMax: 1010
            #   suggestedMin: 990
            # }
        },
        {
            position: "left"
            id: "y-axis-temperature"
            scaleType: "linear"
            # ticks: {
            #   suggestedMax: 30
            #   suggestedMin: 20
            # }
        },
        {
            position: "left"
            id: "y-axis-humidity"
            scaleType: "linear"
            # ticks: {
            #   suggestedMax: 60
            #   suggestedMin: 40
            # }
        }]

  ctx = document.getElementById('chart').getContext('2d')

  window.Chart = new Chart(ctx, config)

  window.Chart.addData = (data) ->
    window.Chart.config.data.labels.push(Number(data.timestamp))
    window.Chart.config.data.datasets[0].data.push(data.temperature)
    window.Chart.config.data.datasets[1].data.push(data.pressure)
    window.Chart.config.data.datasets[2].data.push(data.humidity)
    # while window.Chart.config.data.datasets[0].data.length > 360
    #   window.Chart.config.data.datasets[0].data.shift()
    # while window.Chart.config.data.datasets[1].data.length > 360
    #   window.Chart.config.data.datasets[1].data.shift()
    # while window.Chart.config.data.datasets[2].data.length > 360
    #   window.Chart.config.data.datasets[2].data.shift()
    # while window.Chart.config.data.labels.length > 360
    #   window.Chart.config.data.labels.shift()

    window.Chart.update()

  sensor_id = $('#chart').data("sensor-id")
  # console.log("data id: " + sensor_id)
  $.ajax '/sensors/'+ sensor_id + '.json',
    type: 'GET'
    dataType: 'json'
    success: (data, textStatus, jqXHR) ->
      # $('body').append "Successful AJAX call: #{JSON.stringify(data)}"
      for weather in data.last_values
        window.Chart.addData(
          {
            temperature: weather.temperature
            humidity: weather.humidity
            pressure: weather.pressure
            timestamp: moment(weather.created_at)
          }
        )
