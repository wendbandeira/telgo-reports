class Client < ActiveRecord::Base
  scope :by_callid, -> value { where(callid: value) }
end
