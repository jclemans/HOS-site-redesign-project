require 'spec_helper'

feature 'signed in admin manages programs' do 

	before :each do 
		sign_in(FactoryGirl.create(:admin))
	end

	scenario 'admin creates a program' do
		FactoryGirl.create(:dj, name: "Dustin")

		click_link "Admin Dashboard"
		click_link "Programs"
		click_link "New Program"
		fill_in "Title", with: "DJ Dustin's Twitter Etiquette"
		fill_in "Description", with: "Twitter is amazing, but be careful of these traps..."
		select("Dustin", :from => "program[user_id]")
		click_button "Create Program"
	end

end