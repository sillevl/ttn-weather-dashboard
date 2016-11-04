$ ->
  App.sensors = App.cable.subscriptions.create {
      channel: "SensorsChannel",
      id: $('#chart').data("sensor-id")
    },
    connected: ->
      console.log("Sensor Channel connected")

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      console.log("Sensor update " + JSON.stringify(data))
      window.Chart.addData(
        {
          temperature: data.new_val.temperature
          humidity: data.new_val.humidity
          pressure: data.new_val.pressure
          timestamp: moment(data.new_val.created_at)
        }
      )
      window.Chart.config.data.datasets[0].data.shift()
      window.Chart.config.data.datasets[1].data.shift()
      window.Chart.config.data.datasets[2].data.shift()
      window.Chart.config.data.labels.shift()
      window.Chart.update()
      $('#current-temperature-value').text(data.new_val.temperature)
      $('#current-humidity-value').text(data.new_val.humidity)
      $('#current-pressure-value').text(data.new_val.pressure)
