class QueueLogsController < ApplicationController

  def index
    @queue_logs = QueueLog.events.paginate(page: params[:page], per_page:10)
    @queue_logs = QueueLog.search(params[:datainicial], params[:datafinal]).paginate(page: params[:page],
    per_page: 10) if params[:datainicial].present?

    if params[:datainicial]  and params[:datainicial] != ""
       @queue_log = QueueLog.search(params[:datainicial], params[:datafinal]) if params[:datainicial].present?
    else
      @queue_log = QueueLog.events
    end
    
    respond_to do |format|
        format.html
        format.xls
    end
  end
end
