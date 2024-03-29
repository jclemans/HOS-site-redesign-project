require 'spec_helper'

feature 'signed in admin manages programs' do

	before :each do
		sign_in(FactoryGirl.create(:admin))
	end

	scenario 'admin creates a program' do
		FactoryGirl.create(:dj, name: "Dustin")

		click_link "ADMIN DASHBOARD"
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
		click_link "ADMIN DASHBOARD"
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
		click_link "ADMIN DASHBOARD"
		click_link "Programs"
		within("//tr[@id='program_54']") do
		  click_link "Delete"
    end
    page.should have_content "Program was successfully destroyed"
  end
end

feature 'dj signs in and edits a program' do

  scenario 'dj signs in and goes to the program page' do
    FactoryGirl.create(:user, email: "deejay@email.com", password: "password")
    visit '/users/sign_in'
    fill_in "Email", with: "deejay@email.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    page.should have_content "Signed in successfully."
  end

  scenario 'dj visits the program edit page and updates the program name.' do
    FactoryGirl.create(:user, id: '2', email: "deejay@email.com", password: "password")
    FactoryGirl.create(:program, id: '99', user_id: '2', day_of_week: 1)
    visit '/programs/99/edit'
    click_button 'Update'
    page.should have_content 'Update successful.'
  end
end

feature 'a non-signed-in user cannot edit a program' do

  scenario 'non-signed-in user goes to a program page and cannot edit the program' do
    FactoryGirl.create(:dj, id: '2')
    FactoryGirl.create(:program, id: '99', title: 'We love cats', user_id: '2', day_of_week: 1)
    Schedule.create(start_time: "07:00", duration: 120, program_id: 99, day_of_week: 6)

    visit '/schedules'
    click_link 'We love cats'
    page.should have_content 'We love cats'
    page.should_not have_content 'Edit'
  end
end
