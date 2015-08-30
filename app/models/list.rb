class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_assignments
  has_many :items, through: :list_assignments

  validates_presence_of :name, :user

  def add_item(item)
    ListAssignment.create(item: item, list: self)
  end
end
