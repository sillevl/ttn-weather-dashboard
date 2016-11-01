# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class SensorsChannel < ApplicationCable::Channel
  include NoBrainer::Streams

  def subscribed
    # stream_from "some_channel"
    puts "****************"
    stream_from Weather.all
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
