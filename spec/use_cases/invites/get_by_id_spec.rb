require 'rails_helper'

RSpec.describe Invites::GetById, type: :use_case do

  let(:admin_user) { create(:user, :admin) }
  let(:regular_user) { create(:user) }
  let(:invite) { create(:invite) }

  context 'when called by an admin user' do
    subject { described_class.new(invite.id, admin_user).call }

    it 'returns the invite' do
      result = subject

      expect(result).to eq(invite)
    end
  end

  context 'when called by a regular user with access to the invite' do
    let(:new_invite) { create(:invite, user: regular_user) }
    subject { described_class.new(new_invite.id, regular_user).call }

    it 'returns the invite' do
      result = subject

      expect(result).to eq(new_invite)
    end
  end

  context 'when called by a regular user without access to the invite' do
    let(:other_invite) { create(:invite) }
    subject { described_class.new(other_invite.id, regular_user).call }

    it 'raises ActiveRecord::RecordNotFound' do
      expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
