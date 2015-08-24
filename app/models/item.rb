class Item < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name
  has_many :list_assignments
  has_many :lists, through: :list_assignments
end
