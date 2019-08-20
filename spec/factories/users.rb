FactoryBot.define do
  factory :user do
    name { "MyString" }
    surname { "MyString" }
    date_of_birth { "2019-08-20" }
    position { "MyString" }
    email { "test@email.com" }
  end
end
