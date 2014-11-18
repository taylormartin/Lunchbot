require 'rails_helper'

describe ReviewsController do
	
	before :each do
		@user = create :user
		@restaurant = create :restaurant
		sign_in @user
	end

	it 'shows all the reviews' do
		2.times { create :review, user_id: @user.id }
		reviews = @user.reviews
		get :index
		expect(assigns(:reviews)).to match_array(reviews)
	end

	it 'allows users to create reviews' do
		post :create, review: {rating: 3, restaurant_id: @restaurant.id}
		expect( Review.first.rating ).to eq 3
		expect( Review.first.restaurant_id ).to eq @restaurant.id
	end

	it 'allows users to edit reviews' do
		review = create(:review, rating: 2, user_id: @user.id, restaurant_id: @restaurant.id)
		patch :update, id: review.id, review: {rating: 4}
		expect( Review.first.rating ).to eq 4
	end

	it 'allows users to delete reviews' do
		review = create(:review, user_id: @user.id)
		expect(Review.all.count).to eq 1
		delete :destroy, id: review.id
		expect(Review.all.count).to eq 0
	end

end