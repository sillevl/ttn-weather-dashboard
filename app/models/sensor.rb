class Sensor
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :name, :type => String
  field :appeui, :type => String
  field :description, :type => Text
end
