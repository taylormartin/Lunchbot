require 'rails_helper'

feature 'Add review' do
	before :each do
		@user = create :user
		@restaurant = create :restaurant
		login @user
	end

	it 'allows users to review restaurants' do
		visit new_review_path
		within('form') do
			fill_in "Rating", with: 4
			select(@restaurant.name, from: 'Restaurant')
		end
		click_button "Submit"
		visit reviews_path
		expect(page).to have_content @restaurant.name
	end

	it 'allows users to edit their reviews' do
		@review = create(:review, rating: 4, user_id: @user.id, restaurant_id: @restaurant.id)
		visit edit_review_path(@review)
		within('form') do
			fill_in "New Rating:", with: 3
		end
		click_button "Submit"
		visit reviews_path
		expect(page).to have_content @restaurant.name
		expect(page).to have_content "Rating: 3.0"
	end

	it 'allows users to delete their reviews' do
		review = create(:review, rating: 4, user_id: @user.id, restaurant_id: @restaurant.id)
		visit reviews_path
		expect(page).to have_content review.restaurant.name
		click_on 'Delete'
		expect(page).to have_content "Your review was deleted"
		expect(Review.all.count).to eq 0
	end

end