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
	has_many :reviews

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
		if first_choice != nil
			first_choice
		elsif second_choice != nil
			second_choice
		elsif third_choice != nil
			third_chioce
		elsif fourth_choice != nil
			fourth_choice
		elsif fifth_choice != nil
			fifth_chioce
		elsif sixth_choice != nil
			sixth_choice
		elsif seventh_choice != nil
			seventh_choice
		else
			whatevers_left
		end
	end

	def self.first_choice
		#avg_rating > 4, last_visit > 4 days ago
		res_array = Restaurant.where("avg_rating > ? AND last_visit < ?", 4, (Date.today - 4.days) )
		res_array.sample
	end

	def self.second_choice
		#avg_rating > 3, last_visit > 4 days ago
		res_array = Restaurant.where("avg_rating > ? AND last_visit < ?", 3, (Date.today - 4.days) )
		res_array.sample
	end

	def self.third_choice
		#avg_rating > 2.5, last_visit > 4 days ago
		res_array = Restaurant.where("avg_rating > ? AND last_visit < ?", 2.5, (Date.today - 4.days) )
		res_array.sample
	end

	def self.fourth_choice
		#avg_rating > 4, last_visit > 3 days
		res_array = Restaurant.where("avg_rating > ? AND last_visit < ?", 4, (Date.today - 3.days) )
		res_array.sample
	end

	def self.fifth_choice
		#avg_rating > 3, last_visit > 3 days
		res_array = Restaurant.where("avg_rating > ? AND last_visit < ?", 3, (Date.today - 3.days) )
		res_array.sample
	end

	def self.sixth_choice
		#avg_rating > 2.5, last_visit > 3 days 
		res_array = Restaurant.where("avg_rating > ? AND last_visit < ?", 2.5, (Date.today - 3.days) )
		res_array.sample
	end

	def self.seventh_choice
		#avg_rating > 2.5, wasn't visited yeserday
		res_array = Restaurant.where("avg_rating > ? AND last_visit < ?", 2.5, (Date.today - 1.days) )
		res_array.sample
	end

	def self.eighth_choice
		#wasn't visited yesterday
		res_array = Restaurant.where.not(last_visit: (Date.today - 1.days) )
		res_array.sample
	end

	def self.whatevers_left
		#I give up, just give me whatever's left
		res_array = Restaurant.all
		res_array.sample
	end

end
