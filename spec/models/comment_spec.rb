require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:author) }
  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least(50).is_at_most(600) }
end
