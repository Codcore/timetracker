FactoryBot.define do
  factory :task do
    name { "MyString" }
    description { "MyString" }
    start_date { "2019-08-24" }
    due_date { "2019-08-24" }
    type { "" }
    priority { "MyString" }
    complete_hours { "MyString" }
    performer { nil }
    author { nil }
    project { nil }
  end
end
