require 'rails_helper'

RSpec.describe Invites::Update, type: :use_case do

  let(:invite) { create(:invite) }
  let(:valid_params) { { title: 'Updated Title', description: 'Updated Description', date: Date.tomorrow } }
  let(:invalid_params) { { title: '', description: '', date: nil } }

  subject { described_class.new(invite.id, valid_params).call }

  describe '#call' do
    context 'when the params are valid' do
      it 'updates an invite' do
        updated_invite = subject

        expect(updated_invite).to be_valid
        expect(updated_invite.title).to eq('Updated Title')
        expect(updated_invite.description).to eq('Updated Description')
        expect(updated_invite.date).to eq(Date.tomorrow)
      end
    end

    context 'when the params are invalid' do
      subject { described_class.new(invite.id, invalid_params).call }

      it 'does not update an invite' do
        updated_invite = subject

        expect(updated_invite).not_to be_valid
      end
    end
  end
end
