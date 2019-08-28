require 'rails_helper'

RSpec.describe Task, type: :model do

  let!(:user) { create(:user) }
  let!(:project) { create(:project, author: user) }
  let!(:task) { create(:task, project: project, author: user) }

  it { should belong_to :author }
  it { should belong_to(:performer).optional }
  it { should belong_to :project }
  it { should have_many(:time_logs).dependent(:destroy) }

  it { should define_enum_for(:priority).with_values(hot: 3, high: 2, normal: 1) }
  it { should define_enum_for(:task_type).with_values(feature: 0, bug: 1) }

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_most(140) }
  it { should validate_presence_of :task_type }
  it { should validate_presence_of(:author).on(:create) }
  it { should validate_presence_of(:project).on(:create) }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :due_date }

  describe "#before_save_send_emails" do
    it "sends email to author and performer" do
      with_double = double()
      expect(TaskMailer).to receive(:with).twice.and_return(with_double)
      expect(with_double).to receive(:update_email).twice.and_return(with_double)
      expect(with_double).to receive(:deliver_later).twice

      task.name = "New name"
      task.save
    end
  end
end
