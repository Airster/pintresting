class Pin < ActiveRecord::Base
  # Setup a relationship with a User
	belongs_to :user
end
