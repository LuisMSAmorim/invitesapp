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

    if @user.valid?
      redirect_to administrator_users_path, notice: "Administrador atualizado com sucesso"
    else
      flash[:alert] = "Administrador não pode ser atualizado"
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = Administrators::Create.new(administrator_params).call

    if @user.persisted?
      redirect_to administrator_users_path, notice: "Administrador criado com sucesso"
    else
      flash[:alert] = "Administrador não pode ser criado"
      render :new
    end
  end

  def destroy
    Administrators::Delete.new(params[:id]).call
    redirect_to administrator_users_path, notice: "Administrador deletado com sucesso"
  end

  private

  def administrator_params
    params.require(:user).permit(:email, :password)
  end
end
