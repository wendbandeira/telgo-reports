class QueueLogsController < ApplicationController

  def index
    @queue_logs = QueueLog.events
  end

  def show
  end
end
