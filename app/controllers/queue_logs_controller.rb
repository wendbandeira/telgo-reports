class QueueLogsController < ApplicationController

  def index
    @queue_logs = QueueLog.events.paginate(page: params[:page], per_page:10)
    @queue_logs = QueueLog.search(params[:datainicial], params[:datafinal]).paginate(page: params[:page],
    per_page: 10) if params[:datainicial].present?
  end

  def show
  end
end
