class Agent < ActiveRecord::Base
  validates :name, presence: true
  validates :codeagent, presence: true
  validates :name, uniqueness: true
  validates :codeagent, uniqueness: true
end
