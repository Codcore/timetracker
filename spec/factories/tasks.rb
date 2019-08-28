FactoryBot.define do
  factory :task do
    sequence :name do |n|
      "MyString#{n}"
    end

    description { "MyString" }
    start_date { "2019-08-24" }
    due_date { "2019-08-24" }
    task_type { "bug" }
    priority { "normal" }
    complete_hours { 30 }
    performer
    author
    project
  end
end
