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
    @last_values ||= weathers.where(
      lambda { |doc|
        puts doc[:created_at].time.methods
        # doc[:created_at].to_epoch_time.gt(Time.now - 12.2.hours)
        doc[:created_at].during(Time.now - 1.hours, Time.now)
      }
    )
  end

end
