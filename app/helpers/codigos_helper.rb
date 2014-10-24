module CodigosHelper

  def self.range_hour(hour)
    start = hour.to_i
    ended = hour.to_i + 1
    range_hour_end = "#{start}:00 - #{ended}:00"
  end
end
