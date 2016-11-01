class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def weather
    @sensor = Sensor.where(deveui: weather_params["devEUI"]).first_or_create!()
    Weather.create({
      temperature: weather_params["fields"]["temperature"],
      humidity: weather_params["fields"]["humidity"],
      pressure: weather_params["fields"]["pressure"],
      sensor: @sensor
      })
    respond_to do |format|
        format.html { }
        format.json { render :body => nil, status: :created }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_params
      params.require(:weather).permit(
        :devEUI,
        :fields => [
          :temperature,
          :humidity,
          :pressure
        ]
      )
    end
end
