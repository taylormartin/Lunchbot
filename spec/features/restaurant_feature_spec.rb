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
end