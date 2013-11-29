Given(/^the day is ([^\b]+)$/) do |weekday|
  Timecop.freeze Chronic.parse(weekday) 
end


