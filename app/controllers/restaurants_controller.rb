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

private

	def restaurant_create_params
		params.require(:restaurant).permit(:name)
	end

end