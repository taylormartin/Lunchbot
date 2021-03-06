require 'rails_helper'

feature 'Authentication' do 
	describe 'when logged in do' do
		before :each do
			@user = create :user
			login @user
		end

		it 'has logged the user in' do
			expect(page).to have_content @user.email
		end
	end
end
