FactoryGirl.define do
  factory :review do
  	user
  	restaurant
  	rating		{ Random.rand(1..5) }
  end
end