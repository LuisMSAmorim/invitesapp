require 'rails_helper'

RSpec.describe Invites::GetAll, type: :use_case do
  let(:admin_user) { create(:user, :admin) }
  let(:regular_user) { create(:user) }
  let(:invite_1) { create(:invite, title: 'title 1') }
  let(:invite_2) { create(:invite, title: 'title 2') }

  describe '#call' do
    context 'when called by an admin user' do
      subject { described_class.new(admin_user).call({}) }

      it 'returns all invites' do
        result = subject

        expect(result).to contain_exactly(invite_1, invite_2)
      end
    end

    context 'when called by a regular user' do
      subject { described_class.new(regular_user).call({}) }

      it 'returns user-specific invites' do
        result = subject

        expect(result).to be_empty
      end
    end

    context 'with filtering parameters' do
      let(:company) { create(:company) }

      before do
        invite_1.update(company_id: company.id)
        invite_2.update(company_id: company.id)
      end

      it 'filters invites based on company_id' do
        result = described_class.new(admin_user).call({ company_id: company.id })

        expect(result).to contain_exactly(invite_1, invite_2)
      end

      it 'filters invites based on title' do
        result = described_class.new(admin_user).call({ title: invite_1.title })

        expect(result).to contain_exactly(invite_1)
      end

      it 'filters invites based on inactivation_date' do
        invite_1.update(inactivated_at: Date.yesterday)
        invite_2.update(inactivated_at: Date.yesterday)
        result = described_class.new(admin_user).call({ inactivation_date: Date.today })

        expect(result).to be_empty
      end
    end
  end
end
