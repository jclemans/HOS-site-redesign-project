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
