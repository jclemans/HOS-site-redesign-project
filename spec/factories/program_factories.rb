FactoryGirl.define do
  sequence(:show_time, 0){ |n| (n % 12).to_s.rjust(2,"0") }
    
  factory :program do
    ignore do
      starting { generate :show_time }
    end
    sequence(:name){ |n| "Program #{n}" }
    description Faker::Lorem.sentences 4
    sequence(:deejays){ |n| "DJ Jazzy #{n}" }
    day_of_week 1
    start_hour { starting }
    end_hour { (starting.to_i + 1).to_s.rjust(2,"0") }
    start_minute "01"
    end_minute "59"
    is_active true

    factory :inactive_program do
      is_active false
    end
  end
end
