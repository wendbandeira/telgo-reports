class QueueLogsController < ApplicationController
  def index
    @queue_logs = QueueLog.all
  end

  def show
  end
end
