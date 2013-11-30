Given(/^I fill out the inquiry form correctly$/) do
  fill_in_inquiry
end

Given(/^I fill out the inquiry form except "(.*?)"$/) do |arg1|
  fill_in "Name", with: "Pancha" unless arg1.downcase == 'name'
  fill_in "Email", with: "pancha@massive.com" unless arg1.downcase == 'email'
  fill_in "Subject", with: "Great job all" unless arg1.downcase == 'subject'
  fill_in "Message", with: "I'm really impressed with your station." unless arg1.downcase == 'message'
  fill_in "inquiry[blue_meanies]", with: "blue" unless arg1.downcase == 'blue_meanies'
end

Given(/^I fill out the inquiry form with email "(.*?)"$/) do |arg1|
  fill_in_inquiry email: nil
end

Then(/^I should see a thank you message$/) do
  page.should have_content "Thank You. Your message has been sent"
end

def fill_in_inquiry opts={}
  fill_in "Name", with: "Pancha"
  fill_in "Email", with: opts.has_key?(:email) ? opts[:email] : 'pancha@massive.com'
  fill_in "Subject", with: "Great job all"
  fill_in "Message", with: "I'm really impressed with your station."
  fill_in "inquiry[blue_meanies]", with: "blue"
end
