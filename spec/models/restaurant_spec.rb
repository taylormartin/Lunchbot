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

	it "lunch spot test one" do
		
	end
	
end