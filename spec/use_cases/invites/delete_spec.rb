require 'rails_helper'

RSpec.describe Invites::Delete, type: :use_case do
  let(:invite) { create(:invite) }

  subject { described_class.new(invite.id).call }

  describe '#call' do
    it 'deletes an invite' do
      deleted_invite = subject

      expect(deleted_invite).to be_destroyed
    end
  end
end
