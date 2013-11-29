Then(/^I should see (\d+) shows$/) do |number_of_shows|
  page.all(:css, 'div.program').count.should == number_of_shows.to_i
end
