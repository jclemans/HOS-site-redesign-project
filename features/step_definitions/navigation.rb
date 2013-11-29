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


