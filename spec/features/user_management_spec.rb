require 'spec_helper'

feature 'user signs in and accesses pages' do

  scenario 'user signs in and is directed to home page' do
    FactoryGirl.create(:user, email: "deejay@email.com", password: "password")
    visit '/users/sign_in'
    fill_in "Email", with: "deejay@email.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    page.should have_content "Logged in as deejay@email.com"
  end

  scenario 'user signs in and tries to access admin page without auth' do
    FactoryGirl.create(:user, email: "deejay@email.com", password: "password")
    visit '/users/sign_in'
    fill_in "Email", with: "deejay@email.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    visit '/admin'
    page.should have_content 'Unauthorized Access!'
  end

  scenario 'admin user signs in and visits admin page' do
    admin = FactoryGirl.create(:user, email: "admin@email.com", password: "password")
    admin.add_role "admin"
    visit '/users/sign_in'
    fill_in "Email", with: "admin@email.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    visit '/admin'
    page.should have_content "Dashboard"
    page.should have_content "Powered by Active Admin"
  end

  scenario 'DJ user signs in and tries to access admin page without auth' do
    deejay = FactoryGirl.create(:user, email: "deejay@email.com", password: "password")
    deejay.add_role "DJ"
    visit '/users/sign_in'
    fill_in "Email", with: "deejay@email.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    visit '/admin'
    page.should have_content 'Unauthorized Access!'
  end
end
