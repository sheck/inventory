class ListAssignment < ActiveRecord::Base
  belongs_to :item
  belongs_to :list
  has_one :user, through: :list

  validates_presence_of :item
  validates_presence_of :list
end
