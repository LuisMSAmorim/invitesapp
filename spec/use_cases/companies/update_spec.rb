require 'rails_helper'

RSpec.describe Companies::Update, type: :use_case do

  let(:company) { create(:company) }
  let(:params) { { name: 'John Does CORP', ceo: 'John Doe' } }

  subject { described_class.new(company.id, params).call }

  describe '#call' do
    context "when the params are valid" do
      it 'updates a company' do
        company = subject
        expect(company).to be_persisted
      end
    end
    context "when the params are invalid" do
      let(:params) { { name: '', ceo: '' } }
      it 'dont update a company' do
        company = subject
        expect(company.reload.name).not_to eq(params[:name])
      end
    end
  end
end
