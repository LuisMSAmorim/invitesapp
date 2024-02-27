require 'rails_helper'

RSpec.describe Companies::GetById, type: :use_case do

  let(:company) { create(:company) }

  subject { described_class.new(company.id).call }

  describe '#call' do
    it 'returns the company' do
      companies = subject

      expect(companies).to eq(company)
    end
  end
end
