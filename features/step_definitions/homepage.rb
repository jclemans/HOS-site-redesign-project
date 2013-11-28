Then(/^I should see a welcome message$/) do
  page.should have_content "Welcome to the largest free-form station in Portland, OR"
end
