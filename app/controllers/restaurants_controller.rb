class RestaurantsController < ApplicationController
	
	def index
		@restaurants = Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new restaurant_create_params
		if @restaurant.save
			redirect_to root_path, notice: "#{@restaurant.name} was added to the restaurant database"
		else
			redirect_to root_path, alert: "Restaurants must have a name, try again"
		end
	end

	def visited
		if params["visited"] == nil
			redirect_to root_path, alert: "You forgot to check that you visited the restaurant"
		elsif params["visited"] == "visited"
			restaurant = Restaurant.find_by_id(params[:restaurant_id])
			restaurant.last_visit = Date.today
			restaurant.save!
			redirect_to root_path, notice: "Your visit was saved"
		end
	end

private

	def restaurant_create_params
		params.require(:restaurant).permit(:name)
	end

end