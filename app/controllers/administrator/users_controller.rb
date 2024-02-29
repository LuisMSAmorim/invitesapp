class Administrator::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_administrator!

  def index
    @users = Administrators::GetAll.new.call
  end

  def show
    @user = Administrators::GetById.new(params[:id]).call
  end

  def edit
    @user = Administrators::GetById.new(params[:id]).call
  end

  def update
    @user = Administrators::Update.new(params[:id], administrator_params).call

    respond_to do |format|
      if @user.valid?
        format.html do
          redirect_to administrator_users_path, notice: I18n.t('views.administrators.users.update.success')
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = Administrators::Create.new(administrator_params).call

    respond_to do |format|
      if @user.persisted?
        format.html do
          redirect_to administrator_users_path, notice: I18n.t('views.administrators.users.created.success')
        end
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Administrators::Delete.new(params[:id]).call
    redirect_to administrator_users_path, notice: I18n.t('views.administrators.users.destroy.success')
  end

  private

  def administrator_params
    params.require(:user).permit(:email, :password)
  end
end
