FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    first_name "New"
    last_name "User"
    password "secretPassword"
    password_confirmation "secretPassword"
    
  end

    factory :post do
    	title "Howdy"
	    body "hello"
	    association :user
  end
end