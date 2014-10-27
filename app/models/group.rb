class Group < ActiveRecord::Base
  validates :name, presence: true
  validates :codequeue, presence: true
  validates :name, uniqueness: true
  validates :codequeue, uniqueness: true
end
