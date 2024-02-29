require 'rails_helper'

RSpec.describe Companies::GetAll, type: :use_case do
  let(:company) { create(:company) }

  subject { described_class.new.call }

  describe '#call' do
    it 'returns all companies' do
      companies = subject

      expect(companies).to eq([company])
    end
  end
end
