require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :surname }
end
