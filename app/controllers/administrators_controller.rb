class AdministratorsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_administrator!

  def index
    @administrators = UseCases::Administrators::GetAll.new.call
  end

  def show
    @administrator = UseCases::Administrators::GetById.new.call(params[:id])
  end

  def edit
    @administrator = UseCases::Administrators::GetById.new.call(params[:id])
  end

  def update
    @administrator = UseCases::Administrators::Update.new.call(params[:id], update_params)

    if @administrator.persisted?
      redirect_to root_path, notice: "Administrator updated successfully"
    else
      render :edit
    end
  end

  def new
    @administrator = Administrator.new
  end

  def create
    @administrator = UseCases::Administrators::Create.new.call(create_params)

    if @administrator.persisted?
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
