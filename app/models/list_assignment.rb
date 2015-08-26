class ListAssignment < ActiveRecord::Base
  belongs_to :item
  belongs_to :list
  validates_presence_of :item
  validates_presence_of :list
  has_one :user, through: :list
end
