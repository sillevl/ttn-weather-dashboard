json.extract! sensor, :id, :name, :deveui, :description, :created_at, :updated_at, :last_values
json.url sensor_url(sensor, format: :json)
