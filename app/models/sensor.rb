class Sensor
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :name, :type => String
  field :deveui, :type => String, unique: true, index: true
  field :description, :type => Text

  has_many :weathers

  def last_weather
    @last_weather ||= weathers.last
    puts @last_weather.created_at
    @last_weather
  end

  def last_values
    @last_values ||= weathers.reverse_order.limit(100)
  end

end
