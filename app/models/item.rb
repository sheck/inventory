class Item < ActiveRecord::Base
  belongs_to :user
  has_many :list_assignments, inverse_of: :item
  has_many :lists, through: :list_assignments

  accepts_nested_attributes_for :list_assignments

  validates_presence_of :name
  validates_presence_of :user
end
