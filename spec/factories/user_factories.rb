FactoryGirl.define do

	sequence :name do |n|
		name = Faker::Name.name
	end

	sequence :email do |n|
		email = Faker::Internet.email
	end

  factory :user do
  	name
  	djname { "DJ " + name }
  	phone Faker::PhoneNumber.phone_number
    email
    password "password"
    password_confirmation { password }

    factory :dj do 
    	after(:create) {|user| user.add_role :DJ}
    end

    factory :admin do 
    	after(:create) {|user| user.add_role :Admin}
    end
  end

end
