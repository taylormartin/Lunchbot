class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews

  def get_unreviewed_restaurants
  	reviewed = self.reviews.map { |r| r.restaurant_id }
  	restaurants = Restaurant.where('id NOT IN (:ids)', ids: reviewed)
  end

end
