# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DashboardChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    puts "Dashboard connected !!!!!!!!!!!!!!!!!!!!!!!!!!!"
    stream_from Weather.all
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
