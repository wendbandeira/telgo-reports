class Avaliation < ActiveRecord::Base

  scope :by_callid, -> value { where(callid: value) }

  def has_solution?
    question01 ? 'Sim' : 'Não'
  end

  def score
    question02
  end
end
