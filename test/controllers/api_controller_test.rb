require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest

  setup do
    @params = JSON.parse(File.read(Rails.root.to_s + "/test/fixtures/valid_ttndata.json"))
    Sensor.delete_all
    Weather.delete_all
  end

  test "should post weather" do
    post api_weather_url, params: @params, as: :json
    assert_response :success
  end

  test "should add sensor" do
    assert Sensor.count.zero?
    assert Weather.count.zero?
    post api_weather_url, params: @params, as: :json
    assert Sensor.where( deveui: "000000008EDC7129").present?
  end

  test "should added weather has sensor" do
    assert Weather.count.zero?
    assert Sensor.count.zero?
    post api_weather_url, params: @params, as: :json
    assert Weather.first.id
  end

end
