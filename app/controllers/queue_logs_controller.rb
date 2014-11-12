class QueueLogsController < ApplicationController

  def index
    
    @queue_logs = QueueLog.events(params[:datainicial], params[:datafinal]).paginate(page: params[:page], per_page:20)

    if params[:datainicial]  and params[:datainicial] != ""
      @queue_log = QueueLog.events(params[:datainicial], params[:datafinal])
    end
    
    respond_to do |format|
        format.html
        format.xls
    end
  end
end
