require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :surname }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_confirmation_of :password }
end
