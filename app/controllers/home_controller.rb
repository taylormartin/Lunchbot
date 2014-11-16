class HomeController < ApplicationController

  def index
  	@lunch_spot = Restaurant.find_by_current(true)
  end

  def new_spot
  	Restaurant.update_lunch_spot
  	redirect_to root_path
  end

end
