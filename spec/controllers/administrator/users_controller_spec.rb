require 'rails_helper'

RSpec.describe Administrator::UsersController, type: :controller do

  let(:admin) { create(:user, :admin) }

  let(:admin_mock) { instance_double(User, id: 2, email: 'johndoe@email.com', password: '1243Testing@!@2') }

  before do
    sign_in admin
  end

  describe "GET #index" do
    before do
      allow_any_instance_of(Administrators::GetAll).to receive(:call).and_return([admin, admin_mock])
    end
    
    it "returns http success" do
      get :index
      expect(response).to be_successful
    end
    it "assigns @users" do
      get :index
      expect(assigns(:users)).to eq([admin, admin_mock])
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      allow_any_instance_of(Administrators::GetById).to receive(:call).and_return(admin)
    end
    
    it "returns http success" do
      get :show, params: { id: admin.id }
      expect(response).to be_successful
    end
    it "assigns @user" do
      get :show, params: { id: admin.id }
      expect(assigns(:user)).to eq(admin)
    end
    it "renders the show template" do
      get :show, params: { id: admin.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before do
      allow_any_instance_of(Administrators::GetById).to receive(:call).and_return(admin)
    end
    
    it "returns http success" do
      get :edit, params: { id: admin.id }
      expect(response).to be_successful
    end
    it "assigns @user" do
      get :edit, params: { id: admin.id }
      expect(assigns(:user)).to eq(admin)
    end
    it "renders the edit template" do
      get :edit, params: { id: admin.id }
      expect(response).to render_template("edit")
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      let(:params) { { id: admin_mock.id, user: { email: 'testing@email.com', password: "ChangedPassword123@1" } } }

      before do
        allow_any_instance_of(Administrators::Update).to receive(:call).and_return(admin_mock)
        allow(admin_mock).to receive_messages(valid?: true)
      end

      it "assigns @user" do
        put :update, params: params
        expect(assigns(:user)).to eq(admin_mock)
      end
      it "redirects to the index" do
        put :update, params: params
        expect(response).to redirect_to(administrator_users_path)
      end
    end
    context "with invalid attributes" do
      let(:params) { { id: admin_mock.id, user: { email: '', password: "" } } }

      before do
        allow_any_instance_of(Administrators::Update).to receive(:call).and_return(admin_mock)
        allow(admin_mock).to receive_messages(valid?: false)
      end

      it "returns http success" do
        put :update, params: params
        expect(response).to be_successful
      end
      it "assigns @user" do
        put :update, params: params
        expect(assigns(:user)).to eq(admin_mock)
      end
      it "renders the edit template" do
        put :update, params: params
        expect(response).to render_template("edit")
      end
      it 'flashes an alert' do
        post :create, params: params
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to be_successful
    end
    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do
      let(:params) { { id: admin_mock.id, user: { email: 'testing@email.com', password: "ChangedPassword123@1" } } }

      before do
        allow_any_instance_of(Administrators::Create).to receive(:call).and_return(admin_mock)
        allow(admin_mock).to receive_messages(persisted?: true)
      end

      it "assigns @user" do
        post :create, params: params
        expect(assigns(:user)).to eq(admin_mock)
      end
      it "redirects to the index" do
        post :create, params: params
        expect(response).to redirect_to(administrator_users_path)
      end
    end
    context 'with invalid attributes' do
      let(:params) { { id: admin_mock.id, user: { email: '', password: "" } } }

      before do
        allow_any_instance_of(Administrators::Create).to receive(:call).and_return(admin_mock)
        allow(admin_mock).to receive_messages(persisted?: false)
      end

      it "returns http success" do
        post :create, params: params
        expect(response).to be_successful
      end
      it "assigns @user" do
        post :create, params: params
        expect(assigns(:user)).to eq(admin_mock)
      end
      it "renders the new template" do
        post :create, params: params
        expect(response).to render_template("new")
      end
      it 'flashes an alert' do
        post :create, params: params
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      allow_any_instance_of(Administrators::Delete).to receive(:call)
    end

    it "redirects to the index" do
      delete :destroy, params: { id: admin_mock.id }
      expect(response).to redirect_to(administrator_users_path)
    end
  end
end
