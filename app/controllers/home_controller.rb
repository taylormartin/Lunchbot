class HomeController < ApplicationController

  def index
  	if Restaurant.first == nil
  		redirect_to new_restaurant_path, notice: "The first thing you need to do is add some restaurants to the database"
  	elsif Restaurant.find_by_current(true) == nil
  		Restaurant.update_lunch_spot
  		@lunch_spot = Restaurant.find_by_current(true)
  	else
  		@lunch_spot = Restaurant.find_by_current(true)
  	end
  end

  def new_spot
  	if Restaurant.first == nil
  		redirect_to root_path, alert: "First you need to add some restaurants to the database"
  	else
	  	Restaurant.update_lunch_spot
	  	redirect_to root_path
  	end
  end

end
