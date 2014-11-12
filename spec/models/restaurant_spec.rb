require 'rails_helper'

describe Restaurant do

	it "requires a name" do
		restaurant = build :restaurant, name: nil
		expect(restaurant).not_to be_valid
	end

	it "can compute its average rating" do
		restaurant = build :restaurant
		5.times {restaurant.reviews << create(:review) }
		array = []
		restaurant.reviews.each do |review|
			array << review.rating
		end
		avg = array.inject(0.0) {|sum, element| sum + element } / array.size
		expect(restaurant.avg_rating).to eq avg
	end
	
end