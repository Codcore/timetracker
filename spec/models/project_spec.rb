require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:author) { create(:user, :admin) }
  let!(:project) { create(:project, author: author) }

  it { should belong_to :author }

  it { should validate_presence_of :name }
  it { should validate_presence_of(:slug).on(:create) }
  it { should validate_presence_of(:author).on(:create) }
  it { should validate_uniqueness_of(:slug).on(:create) }
end
