require 'rails_helper'

describe User do

	before :each do
		@user = create :user
	end

	it 'knows which restaurants it has not reviewed' do
		2.times { create(:restaurant) }
		restaurant = Restaurant.first
		create(:review, restaurant_id: restaurant.id, user_id: @user.id)
		unreviewed = @user.get_unreviewed_restaurants
		expect(unreviewed.count).to eq 1
	end

end