module QueueLogsHelper
  def avaliation(callid)
    Avaliation.by_callid(callid).last
  end
end
