require 'rails_helper'

RSpec.describe Invites::Create, type: :use_case do
  let(:user) { create(:user) }
  let(:company) { create(:company) }

  let(:valid_params) do
    { title: 'Event Title', description: 'Event Description', date: Date.today, user_id: user.id,
      company_id: company.id }
  end
  let(:invalid_params) { { title: '', description: '', date: nil, user_id: nil, company_id: nil } }

  subject { described_class.new(valid_params).call }

  describe '#call' do
    context 'when the params are valid' do
      it 'creates an invite' do
        invite = subject

        expect(invite).to be_persisted
      end
    end

    context 'when the params are invalid' do
      subject { described_class.new(invalid_params).call }

      it 'does not create an invite' do
        invite = subject

        expect(invite).not_to be_persisted
      end
    end
  end
end
