class QueueLogsController < ApplicationController

  def index
    calls = apply_filter(QueueLog.select(:callid).uniq)
    calls = calls.by_queue(params[:queue]) if params[:queue].present?
    calls = calls.by_agent(params[:agent]) if params[:agent].present?
    @callids ||= request.format.xls? ? calls : calls.paginate(page: params[:page], per_page: 10)

    @queue_logs = apply_filter(QueueLog)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  private

  def apply_filter(scope)
    scope = scope.
      by_date(params[:datainicial], params[:datafinal]).
      with_callid.
      considered.
      ordered

    callids = params[:callid].blank? && @callids.present? ? @callids.map(&:callid) : params[:callid]
    scope = scope.by_callid(callids) if callids.present?

    scope
  end
end
