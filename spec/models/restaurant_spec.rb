require 'rails_helper'

describe Restaurant do

	it "requires a name" do
		restaurant = build :restaurant, name: nil
		expect(restaurant).not_to be_valid
	end

	it "can compute its average rating" do
		restaurant = create :restaurant
		5.times { create(:review, restaurant_id: restaurant.id) }
		array = restaurant.reviews.map { |r| r.rating }
		avg = array.inject(0.0) {|sum, element| sum + element } / array.size
		restaurant.refresh_avg_rating
		expect(restaurant.avg_rating).to eq avg
	end

	it "algorithm test one" do
		restaurant1 = create(:restaurant, avg_rating: 4, last_visit: Date.today)
		restaurant2 = create(:restaurant, avg_rating: 3, last_visit: Date.today - 5.days)
		expect(Restaurant.get_lunch_spot).to eq restaurant2
	end

	it "algorithm test two" do
		restaurant1 = create(:restaurant, avg_rating: 2.5, last_visit: Date.today - 6.days)
		restaurant2 = create(:restaurant, avg_rating: 4, last_visit: Date.today - 4.days)
		expect(Restaurant.get_lunch_spot).to eq restaurant1
	end

	it "algorithm test three" do
		restaurant1 = create(:restaurant, avg_rating: 4, last_visit: Date.today - 4.days)
		restaurant2 = create(:restaurant, avg_rating: 3, last_visit: Date.today - 4.days)
		expect(Restaurant.get_lunch_spot).to eq restaurant1
	end

	it "algorithm test four" do
		restaurant1 = create(:restaurant, avg_rating: 3, last_visit: Date.today - 4.days)
		restaurant2 = create(:restaurant, avg_rating: 2.5, last_visit: Date.today - 4.days)
		expect(Restaurant.get_lunch_spot).to eq restaurant1
	end

	it "algorithm test five" do
		restaurant1 = create(:restaurant, avg_rating: 2.5, last_visit: Date.today - 4.days)
		restaurant2 = create(:restaurant, avg_rating: 3, last_visit: Date.today - 2.days)
		expect(Restaurant.get_lunch_spot).to eq restaurant1
	end

	it "algorithm test six" do
		restaurant1 = create(:restaurant, avg_rating: 2.5, last_visit: Date.today - 2.days)
		restaurant2 = create(:restaurant, avg_rating: 1, last_visit: Date.today - 2.days)
		expect(Restaurant.get_lunch_spot).to eq restaurant1
	end

	it "algorithm test seven" do
		restaurant1 = create(:restaurant, avg_rating: 1, last_visit: Date.today - 2.days)
		restaurant2 = create(:restaurant, avg_rating: 1, last_visit: Date.today - 1.days)
		expect(Restaurant.get_lunch_spot).to eq restaurant1
	end
	
end