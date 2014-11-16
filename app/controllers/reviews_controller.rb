class ReviewsController < ApplicationController

	def index
		@reviews = current_user.reviews
	end

	def new
		@review = Review.new
		@restaurants = current_user.get_unreviewed_restaurants
	end

	def create
		review = current_user.reviews.new review_create_params
		if review.save
			review.restaurant.refresh_avg_rating
			redirect_to root_path, notice: "Your review was saved"
		else
			redirect_to root_path, alert: "Your rating must be between 1 and 5"
		end
	end

	def edit
		@review = Review.find_by_id(params[:id])
	end

	def update
		review = Review.find_by_id(params[:id])
		review.rating = review_update_params["rating"]
		if review.save
			review.restaurant.refresh_avg_rating
			redirect_to root_path, notice: "Your review was updated"
		else
			redirect_to root_path, alert: "Your rating must be between 1 and 5"
		end
	end

private

	def review_create_params
		params.require(:review).permit(:rating, :restaurant_id)
	end

	def review_update_params
		params.require(:review).permit(:rating)
	end

end