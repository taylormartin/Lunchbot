FactoryGirl.define do
  factory :review do
  	user		{ create :user }
  	restaurant  { create :restaurant }
  	rating		{ Random.rand(1..5) }
  end
end