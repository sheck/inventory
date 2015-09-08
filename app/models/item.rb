class Item < ActiveRecord::Base
  belongs_to :user
  has_many :list_assignments, inverse_of: :item
  has_many :lists, -> { distinct }, through: :list_assignments

  accepts_nested_attributes_for :list_assignments

  validates_presence_of :name
  validates_presence_of :user

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
