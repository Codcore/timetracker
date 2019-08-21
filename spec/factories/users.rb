FactoryBot.define do
  factory :user do
    name { "MyString" }
    surname { "MyString" }
    date_of_birth { "2019-08-20" }
    position { "MyString" }

    sequence :email do |n|
      "test#{n}@email.com"
    end

    password { "123456" }
    password_confirmation { "123456" }

    trait :admin do
      admin { true }
    end
  end
end
