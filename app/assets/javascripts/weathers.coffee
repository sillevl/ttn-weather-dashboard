# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  config =
    type: 'line'
    data:
      labels: []
      datasets: [
        {
          label: "Temperature"
          data: []
          fill: false
          backgroundColor: "rgba(255, 99, 132, 0.8)"
          borderColor: "rgba(255, 99, 132, 0.8)"
        },
        {
          label: "Pressure"
          data: []
          fill: false
          backgroundColor: "rgba(54, 162, 235, 0.8)"
          borderColor: "rgba(54, 162, 235, 0.8)"
        },
        {
          label:"Humidity"
          data: []
          fill: false
          backgroundColor: "rgba(255, 206, 86, 0.8)"
          borderColor: "rgba(255, 206, 86, 0.8)"
        } ]
    options: scales: xAxes: [ {
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
  ctx = document.getElementById('myChart').getContext('2d')

  window.Chart = new Chart(ctx, config)

  window.Chart.addData = (data) ->
    window.Chart.config.data.labels.push(Number(data.timestamp))
    window.Chart.config.data.datasets[0].data.push(data.temperature)
    window.Chart.config.data.datasets[1].data.push(data.pressure)
    window.Chart.config.data.datasets[2].data.push(data.humidity)
    window.Chart.update()

  $.ajax '/weathers.json',
    type: 'GET'
    dataType: 'json'
    success: (data, textStatus, jqXHR) ->
      # $('body').append "Successful AJAX call: #{JSON.stringify(data)}"
      for weather in data
        window.Chart.addData(
          {
            temperature: weather.temperature
            humidity: weather.humidity
            pressure: weather.pressure
            timestamp: moment(weather.created_at)
          }
        )
