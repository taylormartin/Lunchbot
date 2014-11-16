class AddCurrentToRestaurant < ActiveRecord::Migration
  def change
  	add_column :restaurants, :current, :boolean, default: false
  end
end
