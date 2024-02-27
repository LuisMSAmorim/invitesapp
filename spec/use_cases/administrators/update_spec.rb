require 'rails_helper'

RSpec.describe Administrators::Update, type: :use_case do

  let(:admin) { create(:user, :admin) }
  let(:params) { { email: 'johndoe@email.com', password: '123Test@!#' } }

  subject { described_class.new(admin.id, params) }

  describe '#call' do
    context 'when the user is an admin and the params are valid' do
      it 'updates the admin' do
        user_administrator = subject.call

        expect(user_administrator).to be_persisted
        expect(user_administrator.email).to eq(params[:email])
      end
    end
    context 'when the params are invalid' do
      let(:params) { { email: '', password: '' } }
      it 'dont update the admin' do
        expect {
          described_class.new(admin.id, params).call
        }.to_not change { admin.reload.email }
      end
    end
    context 'when the user is not an admin' do
      let(:user) { create(:user) }
      subject { described_class.new(user.id, params) }
      it 'raises an error' do
        expect { subject.call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
