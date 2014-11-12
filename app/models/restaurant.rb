class Restaurant < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :reviews

	def avg_rating
		reviews = self.reviews
		ratings = []
		reviews.each do |rev|
			ratings << rev.rating
		end
		avg = ratings.inject(0.0) { |sum, element| sum + element } / ratings.size
	end

end
