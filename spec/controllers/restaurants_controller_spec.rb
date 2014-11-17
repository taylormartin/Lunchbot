require 'rails_helper'

describe RestaurantsController do 

  before :each do
    @user = create :user
    sign_in @user
  end

  it "shows all the restaurants" do
  	2.times { create :restaurant }
  	restaurants = Restaurant.all
  	get :index 
  	expect(assigns(:restaurants)).to match_array(restaurants)
  end

  it "allows users to add restaurants" do
    post :create, restaurant: {name: "McDonalds"}
    expect( Restaurant.first.name ).to eq "McDonalds"
  end

end