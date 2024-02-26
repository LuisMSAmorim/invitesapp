require 'rails_helper'

RSpec.describe Administrators::GetAll, type: :use_case do

  let(:admin) { create(:user, :admin) }
  let(:admin2) { create(:user, :admin) }
  let(:user) { create(:user) }

  subject { described_class.new }

  describe '#call' do
    it 'returns all administrators' do
      administrators = subject.call

      expect(administrators).to include(admin)
      expect(administrators).to include(admin2)
      expect(administrators).not_to include(user)
    end
  end
end
