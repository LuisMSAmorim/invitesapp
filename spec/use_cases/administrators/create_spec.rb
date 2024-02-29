require 'rails_helper'

RSpec.describe Administrators::Create, type: :use_case do
  let(:params) { { email: 'johndoe@email.com', password: '123Test@!#' } }

  subject { described_class.new(params) }

  describe '#call' do
    context 'when the params are valid' do
      it 'creates an administrator' do
        user_administrator = subject.call

        expect(user_administrator).to be_persisted
        expect(user_administrator.role).to eq('admin')
      end
    end
    context 'when the params are invalid' do
      let(:params) { { email: '', password: '' } }
      it 'dont create an administrator' do
        user_administrator = subject.call
        expect(user_administrator).not_to be_persisted
      end
    end
  end
end
