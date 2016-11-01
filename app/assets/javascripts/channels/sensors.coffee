App.sensors = App.cable.subscriptions.create "SensorsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    tempreature_selector = "#sensor-" + data.new_val.sensor_id + " .values .temperature .value"
    pressure_selector = "#sensor-" + data.new_val.sensor_id + " .values .pressure .value"
    humidity_selector = "#sensor-" + data.new_val.sensor_id + " .values .humidity .value"
    $(tempreature_selector).text(data.new_val.temperature)
    $(pressure_selector).text(data.new_val.pressure)
    $(humidity_selector).text(data.new_val.humidity)
