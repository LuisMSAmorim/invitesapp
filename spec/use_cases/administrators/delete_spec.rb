require 'rails_helper'

RSpec.describe Administrators::Delete, type: :use_case do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  describe '#call' do
    context 'when the user is an admin' do
      it 'deletes the admin' do
        described_class.new(admin.id).call

        expect(User.find_by(id: admin.id)).to be_nil
      end
    end
    context 'when the user is not an admin' do
      it 'raises an error' do
        expect { described_class.new(user.id).call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
