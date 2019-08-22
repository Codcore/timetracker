FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "MyString#{n}" }
    surname { "MyString" }
    date_of_birth { "2019-08-20" }
    position { "MyString" }

    sequence(:email) { |n| "test#{n}@email.com" }

    password { "123456" }
    password_confirmation { "123456" }

    trait :admin do
      admin { true }
    end
  end
end
