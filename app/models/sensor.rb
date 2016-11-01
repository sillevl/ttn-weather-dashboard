class Sensor
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :name, :type => String
  field :deveui, :type => String, unique: true
  field :description, :type => Text

  has_many :weathers

  def last_weather
    weathers.order_by(:created_at => :desc).limit(1).first
  end
end
