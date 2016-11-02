# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class SensorsChannel < ApplicationCable::Channel
  include NoBrainer::Streams

  def subscribed
    stream_from Sensor.find(params[:id]).weathers
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
