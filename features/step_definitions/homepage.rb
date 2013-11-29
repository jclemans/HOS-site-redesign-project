Then(/^I should see a welcome message$/) do
  page.should have_content "Welcome to the largest free-form station in Portland, OR"
end

Then(/^I should see that the station has (\d+) shows$/) do |arg1|
  page.should have_content "with #{arg1.to_i.to_words} live shows per week"
end

