When(/^I click "(.*?)"$/) do |arg1|
  click_button arg1
end

Then(/^I should see an error message$/) do
  page.should have_content "There were problems with the following fields"
end



