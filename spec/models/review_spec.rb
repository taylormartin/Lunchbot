require 'rails_helper'

describe Review do

  %i{user restaurant rating}.each do |field|
    it "requires a #{field}" do
      review = build :review, field => nil
      expect(review).not_to be_valid
    end
  end

end