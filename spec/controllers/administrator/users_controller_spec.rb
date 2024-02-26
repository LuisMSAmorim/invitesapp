require 'rails_helper'

RSpec.describe Administrator::UsersController, type: :controller do

  let(:admin) { create(:user, :admin) }

  let(:admin_mock) { instance_double(User, id: 2) }

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
end
