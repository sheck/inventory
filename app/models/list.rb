class List < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :user
  has_many :list_assignments
  has_many :items, through: :list_assignments
end
