require 'rails_helper'

RSpec.describe InvitesController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let(:regular_user) { create(:user) }
  let(:company) { create(:company) }
  let(:invite) { create(:invite) }

  describe 'GET #index' do
    context 'when user is admin' do
      before { sign_in admin_user }

      it 'returns http success' do
        get :index
        expect(response).to be_successful
      end

      it 'assigns @invites' do
        allow_any_instance_of(Invites::GetAll).to receive(:call).and_return([])
        get :index
        expect(assigns(:invites)).to eq([])
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'when user is not admin' do
      before { sign_in regular_user }

      it 'returns http success' do
        get :index
        expect(response).to be_successful
      end

      it 'assigns @invites' do
        allow_any_instance_of(Invites::GetAll).to receive(:call).and_return([])
        get :index
        expect(assigns(:invites)).to eq([])
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end
  end

  describe 'GET #show' do
    let(:invite) { create(:invite) }

    before { sign_in admin_user }

    it 'returns http success' do
      get :show, params: { id: invite.id }
      expect(response).to be_successful
    end

    it 'assigns @invite' do
      allow_any_instance_of(Invites::GetById).to receive(:call).and_return(invite)
      get :show, params: { id: invite.id }
      expect(assigns(:invite)).to eq(invite)
    end

    it 'renders the show template' do
      get :show, params: { id: invite.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #edit' do
    before { sign_in admin_user }

    it 'returns http success' do
      get :edit, params: { id: invite.id }
      expect(response).to be_successful
    end

    it 'assigns @invite' do
      allow_any_instance_of(Invites::GetById).to receive(:call).and_return(invite)
      get :edit, params: { id: invite.id }
      expect(assigns(:invite)).to eq(invite)
    end

    it 'renders the edit template' do
      get :edit, params: { id: invite.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH #update' do
    let(:valid_params) { attributes_for(:invite, title: 'Updated Title') }

    before { sign_in admin_user }

    context 'with valid attributes' do
      it 'redirects to invites url' do
        allow_any_instance_of(Invites::Update).to receive(:call).and_return(invite)
        allow(invite).to receive(:valid?).and_return(true)
        patch :update, params: { id: invite.id, invite: valid_params }
        expect(response).to redirect_to(invite_url(invite))
      end

      it 'assigns @invite' do
        allow_any_instance_of(Invites::Update).to receive(:call).and_return(invite)
        allow(invite).to receive(:valid?).and_return(true)
        patch :update, params: { id: invite.id, invite: valid_params }
        expect(assigns(:invite)).to eq(invite)
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        allow_any_instance_of(Invites::Update).to receive(:call).and_return(invite)
        allow(invite).to receive(:valid?).and_return(false)
        patch :update, params: { id: invite.id, invite: valid_params }
        expect(response).to render_template('edit')
      end

      it 'assigns @invite' do
        allow_any_instance_of(Invites::Update).to receive(:call).and_return(invite)
        allow(invite).to receive(:valid?).and_return(false)
        patch :update, params: { id: invite.id, invite: valid_params }
        expect(assigns(:invite)).to eq(invite)
      end
    end
  end

  describe 'GET #new' do
    before { sign_in admin_user }

    it 'returns http success' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns @invite' do
      get :new
      expect(assigns(:invite)).to be_a_new(Invite)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    let(:valid_params) { attributes_for(:invite) }

    before { sign_in admin_user }

    context 'with valid attributes' do
      it 'redirects to invite_url' do
        allow_any_instance_of(Invites::Create).to receive(:call).and_return(invite)
        allow(invite).to receive(:save).and_return(true)
        post :create, params: { invite: valid_params }
        expect(response).to redirect_to(invite_url(invite))
      end

      it 'assigns @invite' do
        allow_any_instance_of(Invites::Create).to receive(:call).and_return(invite)
        allow(invite).to receive(:save).and_return(true)
        post :create, params: { invite: valid_params }
        expect(assigns(:invite)).to eq(invite)
      end
    end

    context 'with invalid attributes' do
      it 'renders the new template' do
        allow_any_instance_of(Invites::Create).to receive(:call).and_return(invite)
        allow(invite).to receive(:save).and_return(false)
        post :create, params: { invite: valid_params }
        expect(response).to render_template('new')
      end

      it 'assigns @invite' do
        allow_any_instance_of(Invites::Create).to receive(:call).and_return(invite)
        allow(invite).to receive(:save).and_return(false)
        post :create, params: { invite: valid_params }
        expect(assigns(:invite)).to eq(invite)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in admin_user }

    it 'redirects to invites_url' do
      allow_any_instance_of(Invites::Delete).to receive(:call)
      delete :destroy, params: { id: invite.id }
      expect(response).to redirect_to(invites_url)
    end
  end

  describe 'PATCH #inactivate' do
    before { sign_in admin_user }

    it 'redirects to invites_url' do
      allow_any_instance_of(Invites::Update).to receive(:call).and_return(invite)
      allow(invite).to receive(:update).and_return(true)
      patch :inactivate, params: { id: invite.id }
      expect(response).to redirect_to(invites_url)
    end
  end
end
