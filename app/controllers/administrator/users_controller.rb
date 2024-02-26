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
    @user = Administrators::Update.new(params[:id], update_params).call

    if @user.persisted?
      redirect_to root_path, notice: "Administrator updated successfully"
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = Administrators::Create.new(create_params).call

    if @user.persisted?
      redirect_to root_path, notice: "Administrator created successfully"
    else
      render :new, alert: "Administrator could not be created"
    end
  end

  def destroy
    Administrators::Delete.new(params[:id]).call
    redirect_to root_path, notice: "Administrator deleted successfully"
  end

  private

  def authorize_administrator!
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action"
    end
  end

  def create_params
    params.require(:user).permit(:email, :password)
  end
end
