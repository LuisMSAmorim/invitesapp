require 'rails_helper'

RSpec.describe Companies::Delete, type: :use_case do
  let(:company) { create(:company) }

  subject { described_class.new(company.id).call }

  describe '#call' do
    it 'deletes a company' do
      company = subject

      expect(company).to be_destroyed
    end
  end
end
