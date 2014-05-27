FactoryGirl.define do
  sequence :title do |n|
    "Test Program #{n}"
  end

  sequence :description do |n|
    "Test description #{n}"
  end

  sequence :id do |n|
    "#{n}"
  end

  factory :program do
    id
    user_id 9
    title
    description
   end
end
