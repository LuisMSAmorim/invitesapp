require 'rails_helper'

RSpec.describe Companies::Create, type: :use_case do
  let(:params) { { name: 'John Does CORP', ceo: 'John Doe' } }

  subject { described_class.new(params).call }

  describe '#call' do
    context 'when the params are valid' do
      it 'creates a company' do
        company = subject

        expect(company).to be_persisted
      end
    end
    context 'when the params are invalid' do
      let(:params) { { name: '', ceo: '' } }
      it 'dont create a company' do
        company = subject
        expect(company).not_to be_persisted
      end
    end
  end
end
