class QueueLogsController < ApplicationController

  def index
    @queue_logs = QueueLog.events.paginate(page: params[:page], per_page: 20 )
  end

  def show
  end
end
