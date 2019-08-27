require 'rails_helper'

RSpec.describe TimeLog, type: :model do
  it { should belong_to :task }
  it { should validate_presence_of :hours}
  it { should validate_numericality_of(:hours).is_less_than(10).is_greater_than(0) }
end
