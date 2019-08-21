require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:project) { create(:project) }

  it { should validate_presence_of :name }
  it { should validate_presence_of(:slug).on(:save) }
  it { should validate_uniqueness_of(:slug).on(:save) }
end
