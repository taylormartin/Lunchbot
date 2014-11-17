class ChangeColumnInRestaurant < ActiveRecord::Migration
  def change
  	change_column :restaurants, :last_visit, :date, default: "2000-01-01"
  end
end
