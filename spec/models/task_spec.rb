require 'rails_helper'

RSpec.describe Task, type: :model do

  it { should belong_to :author }
  it { should belong_to :performer }
  it { should belong_to :project }

  it { should define_enum_for(:priority).with_values(hot: 3, high: 2, normal: 1) }
  it { should define_enum_for(:task_type).with_values(["feature", "bug"]).backed_by_column_of_type(:string) }

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_most(140) }
  it { should validate_presence_of :task_type }
  it { should validate_presence_of(:author).on(:create) }
  it { should validate_presence_of(:project).on(:create) }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :due_date }
end
