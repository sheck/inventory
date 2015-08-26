class User < ActiveRecord::Base
  include Clearance::User
  has_many :items, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :list_assignments, through: :lists, dependent: :destroy
end
