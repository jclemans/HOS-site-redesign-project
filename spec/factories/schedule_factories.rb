FactoryGirl.define do

  sequence(:program_id, 4) { |n| "#{n}" }
  # sequence(:start_time, Time.now + rand(24)) { |time| "#{time}" }


  factory :schedule do
    program_id
    start_time '12:00'
    duration 120
    days_of_week [0]
  end
end
