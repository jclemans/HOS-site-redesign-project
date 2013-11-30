Given(/^There are (\d+) active shows$/) do |arg1|
  arg1.to_i.times do
    FactoryGirl.create :program
  end
end

Given(/^There are (\d+) inactive shows$/) do |arg1|
  arg1.to_i.times do
    FactoryGirl.create :inactive_program
  end
end

Given(/^there are (\d+) active shows on ([^\b]+)$/) do |number_of_shows, weekday|
  wday = Chronic.parse(weekday).wday
  number_of_shows.to_i.times do 
    FactoryGirl.create :program, day_of_week: wday
  end
end

Given(/^"(.*?)" is a show$/) do |arg1|
  FactoryGirl.create :program, name: arg1
end


