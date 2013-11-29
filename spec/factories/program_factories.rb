FactoryGirl.define do
  factory :program do
    sequence(:name){ |n| "Program #{n}" }
    description Faker::Lorem.sentences 4
    sequence(:deejays){ |n| "DJ Jazzy #{n}" }
    day_of_week 1
    start_hour 1
    start_minute 0
    end_hour 3
    end_minute 59
    is_active true

    factory :inactive_program do
      is_active false
    end
  end
end
