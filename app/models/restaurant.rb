# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  avg_rating :float
#  last_visit :date
#  created_at :datetime
#  updated_at :datetime
#  current    :boolean          default(FALSE)
#

class Restaurant < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :reviews, dependent: :destroy

	def refresh_avg_rating
		ratings = self.reviews.map { |r| r.rating }
		avg = ratings.inject(0.0) { |sum, element| sum + element } / ratings.size
		self.avg_rating = avg
		self.save!
	end

	def self.update_lunch_spot
		#get the restaurant from yesterday and set current to false
		yesterday_spot = Restaurant.find_by_current(true)
		unless yesterday_spot == nil
			yesterday_spot.current = false
			yesterday_spot.save!
		end
		#get a new restaurant and set current to true
		restaurant = get_lunch_spot
		restaurant.current = true
		restaurant.save!
	end

	def self.get_lunch_spot
		query_one(4,   4)	||
		query_one(3,   4)	||
		query_one(2.5, 4)	||
		query_one(4,   3)	||
		query_one(3,   3)	||
		query_one(2.5, 3)	||
		query_one(2.5, 1)	||
		query_two(1)		||
		whatevers_left
	end

	def self.query_one (rating, day_count)
		res_array = Restaurant.where("avg_rating >= ? AND last_visit < ?", rating, Date.today - day_count.days)
		res_array.sample
	end

	def self.query_two (day_count)
		res_array = Restaurant.where.not(last_visit: (Date.today - day_count.days) )
		res_array.sample
	end

	def self.whatevers_left
		res_array = Restaurant.all
		res_array.sample
	end
end