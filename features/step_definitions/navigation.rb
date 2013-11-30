When(/^I go to the homepage$/) do
  visit "/"
end

When(/^I go to the programs page$/) do
  visit "/programs"
end

When(/^I click on ([^\b]+) in the day nav$/) do |weekday|
  within("div.program_days") do
    click_link(weekday.upcase)
  end
end

When(/^I go to the weekly schedule$/) do
  visit "/programs/all"
end

When(/^I go to the show page for "(.*?)"$/) do |program_name|
  program = Program.where(name: program_name).first
  visit program_path(program)
end

Given(/^I am on the new inquiry page$/) do
  visit new_inquiry_path
end


