require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let(:admin) { create(:user, :admin) }

  let(:company_mock) { instance_double(Company, id: 1, name: 'John Doe Company', ceo: 'John Doe') }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    before do
      allow_any_instance_of(Companies::GetAll).to receive(:call).and_return([company_mock])
    end

    it 'returns http success' do
      get :index
      expect(response).to be_successful
    end
    it 'assigns @companies' do
      get :index
      expect(assigns(:companies)).to eq([company_mock])
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    before do
      allow_any_instance_of(Companies::GetById).to receive(:call).and_return(company_mock)
    end

    it 'returns http success' do
      get :show, params: { id: company_mock.id }
      expect(response).to be_successful
    end
    it 'assigns @companies' do
      get :show, params: { id: company_mock.id }
      expect(assigns(:company)).to eq(company_mock)
    end
    it 'renders the show template' do
      get :show, params: { id: company_mock.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #edit' do
    before do
      allow_any_instance_of(Companies::GetById).to receive(:call).and_return(company_mock)
    end

    it 'returns http success' do
      get :edit, params: { id: company_mock.id }
      expect(response).to be_successful
    end
    it 'assigns @company' do
      get :edit, params: { id: company_mock.id }
      expect(assigns(:company)).to eq(company_mock)
    end
    it 'renders the edit template' do
      get :edit, params: { id: company_mock.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'POST #update' do
    context 'with valid attributes' do
      before do
        allow_any_instance_of(Companies::Update).to receive(:call).and_return(company_mock)
        allow(company_mock).to receive_messages(valid?: true)
      end

      it 'redirects to companies_path' do
        put :update, params: { id: company_mock.id, company: { name: 'John Doe Company', ceo: 'John Doe' } }
        expect(response).to redirect_to(companies_path)
      end
      it 'assigns @company' do
        put :update, params: { id: company_mock.id, company: { name: 'John Doe Company', ceo: 'John Doe' } }
        expect(assigns(:company)).to eq(company_mock)
      end
    end
    context 'with invalid attributes' do
      before do
        allow_any_instance_of(Companies::Update).to receive(:call).and_return(company_mock)
        allow(company_mock).to receive_messages(valid?: false)
      end

      it 'renders the edit template' do
        put :update, params: { id: company_mock.id, company: { name: 'John Doe Company', ceo: '' } }
        expect(response).to render_template('edit')
      end
      it 'assigns @company' do
        put :update, params: { id: company_mock.id, company: { name: 'John Doe Company', ceo: '' } }
        expect(assigns(:company)).to eq(company_mock)
      end
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to be_successful
    end
    it 'assigns @company' do
      get :new
      expect(assigns(:company)).to be_a_new(Company)
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        allow_any_instance_of(Companies::Create).to receive(:call).and_return(company_mock)
        allow(company_mock).to receive_messages(persisted?: true)
      end

      it 'redirects to companies_path' do
        post :create, params: { company: { name: 'John Doe Company', ceo: 'John Doe' } }
        expect(response).to redirect_to(companies_path)
      end
      it 'assigns @company' do
        post :create, params: { company: { name: 'John Doe Company', ceo: 'John Doe' } }
        expect(assigns(:company)).to eq(company_mock)
      end
    end
    context 'with invalid attributes' do
      before do
        allow_any_instance_of(Companies::Create).to receive(:call).and_return(company_mock)
        allow(company_mock).to receive_messages(persisted?: false)
      end

      it 'renders the new template' do
        post :create, params: { company: { name: 'John Doe Company', ceo: '' } }
        expect(response).to render_template('new')
      end
      it 'assigns @company' do
        post :create, params: { company: { name: 'John Doe Company', ceo: '' } }
        expect(assigns(:company)).to eq(company_mock)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      allow_any_instance_of(Companies::Delete).to receive(:call)
    end

    it 'redirects to companies_path' do
      delete :destroy, params: { id: company_mock.id }
      expect(response).to redirect_to(companies_path)
    end
  end
end
