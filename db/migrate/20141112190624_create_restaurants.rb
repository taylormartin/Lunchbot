class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.float  :avg_rating
      t.date   :last_visit
      t.timestamps
    end
  end
end
