class Administrator::UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :authorize_administrator!

  def index
    @users = Administrators::GetAll.new.call
  end

  def show
    @user = Administrators::GetById.new.call(params[:id])
  end

  def edit
    @user = Administrators::GetById.new.call(params[:id])
  end

  def update
    @user = Administrators::Update.new.call(params[:id], update_params)

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
    @user = Administrators::Create.new.call(create_params)

    if @user.persisted?
      redirect_to root_path, notice: "Administrator created successfully"
    else
      render :new
    end
  end

  private

  def authorize_administrator!
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action"
    end
  end

  def create_params
    params.require(:administrator).permit(:email, :password)
  end
end
