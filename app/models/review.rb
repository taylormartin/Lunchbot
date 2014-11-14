class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :restaurant
	validates_presence_of :rating, :user_id, :restaurant_id
	validates :rating, numericality: {
		greater_than_or_equal_to: 1,
		less_than_or_equal_to: 5
	}
end
