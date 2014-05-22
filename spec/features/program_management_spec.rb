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




end
