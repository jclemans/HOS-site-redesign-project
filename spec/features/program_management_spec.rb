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
		page.should have_content "DJ Dustin's Twitter Etiquette"
		page.should have_content "Program was successfully created"
	end

	scenario 'admin edits a program' do
		FactoryGirl.create(:dj, name: "Dustin")
		FactoryGirl.create(:program, id: 35)
		click_link "Admin Dashboard"
		click_link "Programs"
		within("//tr[@id='program_35']") do
			click_link "Edit"
		end
		fill_in "Title", with: "New Title"
		fill_in "Description", with: "Description is different"
		select("Dustin", :from => "program[user_id]")
		click_button "Update Program"
		page.should have_content "Program was successfully updated"
		page.should have_content "New Title"
		page.should have_content "Description is different"
	end

	scenario 'admin deletes a program' do
		FactoryGirl.create(:program, id: 54)
		click_link "Admin Dashboard"
		click_link "Programs"
		within("//tr[@id='program_54']") do
			click_link "Delete"
		end
		page.should have_content "Program was successfully destroyed"
	end
end
