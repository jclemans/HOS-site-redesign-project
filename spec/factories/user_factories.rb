FactoryGirl.define do

  factory :user do
  	name Faker::Name.name
  	djname { "DJ " + name }
  	phone Faker::PhoneNumber.phone_number
    email Faker::Internet.email
    password "password"
    password_confirmation { password }
  end

end
