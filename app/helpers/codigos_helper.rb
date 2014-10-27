module CodigosHelper

  def self.range_hour(hour)
    start = hour.to_i
    ended = hour.to_i + 1
    range_hour_end = "#{start}:00 - #{ended}:00"
  end

  def self.queue_name(code)
    namequeue = Group.find_by(codequeue: code)
    return namequeue.blank? ? code : namequeue.name
  end
end
