require 'spec_helper'

feature 'user signs in and accesses pages' do

  scenario 'user signs in and is directed to home page' do
    FactoryGirl.create(:user, email: "deejay@email.com", password: "password")
    
    visit '/users/sign_in'
    fill_in "Email", with: "deejay@email.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    page.should have_content "Signed in successfully."
  end

  scenario 'user signs in and signs out' do
    FactoryGirl.create(:dj, email: "deejay@email.com", password: "password")

    visit '/users/sign_in'
    fill_in "Email", with: "deejay@email.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    click_link "Sign Out"
    page.should have_content "Signed out successfully."
  end

  scenario 'user signs in and tries to access admin page without auth' do
    sign_in(FactoryGirl.create(:dj, email: "deejay@email.com", password: "password"))
    
    visit '/admin'
    page.should have_content 'Unauthorized Access!'
  end

  scenario 'admin user signs in and visits admin page' do
    sign_in(FactoryGirl.create(:admin, email: "admin@email.com", password: "password"))
    
    click_link "Admin Dashboard"
    page.should have_content "Dashboard"
    page.should have_content "Powered by Active Admin"
  end

  scenario 'DJ user signs in and tries to access admin page without auth' do
    sign_in(FactoryGirl.create(:dj, email: "deejay@email.com", password: "password"))
    
    visit '/admin'
    page.should have_content 'Unauthorized Access!'
  end

  scenario 'admin user signs in and visits admin page to create new user' do
    sign_in(FactoryGirl.create(:admin, email: "admin@email.com", password: "password"))
    
    click_link "Admin Dashboard"
    click_link "Users"
    click_link "New User"
    fill_in :user_name, with: "Fred Flintstone"
    fill_in "DJ Name", with: "DJ Flint"
    fill_in "Phone", with: "345-999-9999"
    fill_in "Email", with: "fred@flintstone.com"
    fill_in :user_password, with: "password"
    fill_in :user_password_confirmation, with: "password"
    click_button "Create User"
    page.should have_content "User was successfully created."
  end

  scenario 'DJ signs in and edits profile page' do
    sign_in(FactoryGirl.create(:dj, email: "deej@email.com", password: "password", id: 55))
    
    click_link "Edit Profile"
    fill_in "DJ Name", with: "DJ Today"
    click_button "Update"
    page.should have_content "DJ Today"
  end

  scenario 'DJ signs in and tries to edit different user page' do
    sign_in(FactoryGirl.create(:dj, email: "dj@example.com", password: "password", id: 2))
    FactoryGirl.create(:admin, id: 3)
    
    visit "/users/3/edit"
    page.should have_content "You are not authorized to access this page."
  end
end
