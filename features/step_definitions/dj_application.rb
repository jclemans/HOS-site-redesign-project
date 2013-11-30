Given(/^I fill out the dj application form correctly$/) do
  fill_in_dj_app
end

Given(/^I fill out the dj application except for email$/) do
  fill_in_dj_app email: nil
end

Then(/^I should see a validation error on the dj application$/) do
    pending # express the regexp above with the code you wish you had
end

Then(/^I should see a thank you message for the dj application$/) do
  page.should have_content "Thank you. Your application has been submitted"
end

def fill_in_dj_app opts={}
  fill_in "dj_application_name", with: 'Oliver'
  fill_in "dj_application_email", with: opts.has_key?(:email) ? opts[:email] : 'oliver@twist.com'
  fill_in "dj_application_phone", with: '503-232-9931'
  fill_in 'dj_application_show_description', with: 'Awesome sauce'
  fill_in 'dj_application_show_name', with: 'Spinning it'
  fill_in 'dj_application_dj_name', with: 'Frank the Spinner'
  check 'dj_application_is_cost_ok'
  fill_in 'dj_application_availability', with: 'any time, any place'
  fill_in 'dj_application_internal_contacts', with: 'I fly solo'
  fill_in 'dj_application_blue_meanies', with: 'blue'
end

