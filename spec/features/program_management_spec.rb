require 'spec_helper'

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
    FactoryGirl.create(:program, id: '99')
    sign_in(FactoryGirl.create(:dj, email: "deejay@email.com", password: "password"))
    visit '/programs/99/edit'
    click_button 'Update'
    page.should have_content 'Update successful.'
  end
end
