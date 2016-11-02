class Weather
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :temperature, :type => Float
  field :humidity, :type => Float
  field :pressure, :type => Float

  belongs_to :sensor, required: true, index: true
end
