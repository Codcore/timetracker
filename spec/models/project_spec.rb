require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:author) { create(:user, :admin) }
  let!(:project) { create(:project, author: author) }

  it { should belong_to :author }
  it { should have_and_belong_to_many :users }
  it { should have_many(:tasks).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of :name }
  it { should validate_presence_of(:slug).on(:save) }
  it { should validate_presence_of(:author).on(:create) }
  it { should validate_uniqueness_of(:slug).on(:save) }
end
