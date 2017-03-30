require 'rails_helper'
require 'capybara/rspec'

describe "the login process", :type => :feature do
	before :each do
		User.create(email: 'user@example.com', password: 'password')
	end


	it "logs me in" do
		visit '/users/sign_in'
		fill_in 'Email', with: 'user@example.com'
		fill_in 'Password', with: 'password'

		click_button 'Log in'
		expect(page).to have_content 'Posts'
	end
end