require 'rails_helper'

RSpec.describe Idea, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
end
