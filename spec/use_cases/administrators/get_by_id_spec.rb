require 'rails_helper'

RSpec.describe Administrators::GetById, type: :use_case do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  describe '#call' do
    context 'when the user is an admin' do
      it 'returns the admin' do
        user_administrator = described_class.new(admin.id).call

        expect(user_administrator).to eq(admin)
      end
    end
    context 'when the user is not an admin' do
      it 'returns nil' do
        user_administrator = described_class.new(user.id).call

        expect(user_administrator).to be_nil
      end
    end
  end
end
