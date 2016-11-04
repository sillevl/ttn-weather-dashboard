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
    between
  end

  def between(start_time = Time.now - 2.hours, end_time = Time.now)
    weathers.where(
      lambda { |doc|
        doc[:created_at].during(start_time, end_time)
      }
    )
  end

  def between_grouped(start_time = Time.now - 1.hours, end_time = Time.now, step = 1.minute)
    #method not finished !!!! WIP !!!!!!
    NoBrainer.run { |r|
      between(start_time, end_time).to_rql.group { |g|
        g[:created_at].date
      }
    }
  end

end
