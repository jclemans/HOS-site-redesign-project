Then(/^I should see (\d+) shows$/) do |number_of_shows|
  page.all(:css, 'div.program').count.should == number_of_shows.to_i
end

Then(/^I should see (\d+) shows scheduled$/) do |number_of_shows|
  page.all(:css, 'td.active_start').count.should == number_of_shows.to_i
end
