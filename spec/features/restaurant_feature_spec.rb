require 'rails_helper'

feature 'Add restaurant' do 
	before :each do
		@user = create :user
		login @user
	end

	it 'allows users to add restaurants to the system' do
		visit new_restaurant_path
		within('form') do 
			fill_in "Name", with: "Moes"
		end
		click_button "Submit"
		visit restaurants_path
		expect(page).to have_content "Moes"
	end

	it 'allows users to delete restaurants' do
		restaurant = create :restaurant
		visit restaurants_path
		expect(page).to have_content restaurant.name
		click_on 'Delete'
		expect(page).to have_content "The first thing you need to do is"
		expect(Restaurant.all.count).to eq 0
	end
end