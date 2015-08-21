class User < ActiveRecord::Base
  include Clearance::User
  has_many :items, dependent: :destroy
end
