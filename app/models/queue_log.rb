class QueueLog < ActiveRecord::Base
  belongs_to :group, primary_key: :codequeue, foreign_key: :queuename

  scope :by_date, -> (date1, date2) do
    date1 ||= Date.current
    date2 ||= Date.current
    where(time: date1.to_date.beginning_of_day..date2.to_date.end_of_day)
  end
  scope :with_callid, -> { where.not(callid: 'NONE') }
  scope :ordered, -> { order(arel_table[:id]) }
  scope :by_callid, -> value { where(callid: value) }
  scope :by_queue, -> value { where(queuename: Group.find_by(name: value).try(:codequeue)) }
  scope :by_agent, -> value { where(agent: "Agent/#{Agent.find_by(name: value).try(:codeagent)}") }
  scope :considered, -> do
    where(event: %w(ABANDON COMPLETEAGENT COMPLETECALLER CONNECT ENTERQUEUE EXITWITHTIMEOUT TRANSFER RINGNOANSWER))
  end

  alias_attribute :queue_time, :data1
  alias_attribute :agent_time, :data2

  def agent_relation
    Agent.find_by(codeagent: agent.split('/').last)
  end
end
