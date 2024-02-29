require 'rails_helper'

RSpec.describe Invite, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:user) }
  end
end
