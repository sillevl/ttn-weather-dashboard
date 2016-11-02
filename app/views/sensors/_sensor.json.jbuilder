json.extract! sensor, :id, :name, :deveui, :description, :created_at, :updated_at
json.url sensor_url(sensor, format: :json)
json.last_values @last_values
