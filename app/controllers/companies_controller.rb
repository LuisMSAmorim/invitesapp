class CompaniesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :authorize_administrator!

  def index
    @companies = Companies::GetAll.new.call
  end

  def show
    @company = Companies::GetById.new(params[:id]).call
  end

  def edit
    @company = Companies::GetById.new(params[:id]).call
  end

  def update
    @company = Companies::Update.new(params[:id], company_params).call

    if @company.valid?
      redirect_to companies_path, notice: "Empresa atualizada com sucesso"
    else
      flash[:alert] = "Empresa não pode ser atualizada"
      render :edit
    end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Companies::Create.new(company_params).call

    if @company.persisted?
      redirect_to companies_path, notice: "Empresa criada com sucesso"
    else
      flash[:alert] = "Empresa não pode ser criada"
      render :new
    end
  end

  def destroy
    Companies::Delete.new(params[:id]).call
    redirect_to companies_path, notice: "Empresa deletada com sucesso"
  end

  private

    def company_params
      params.require(:company).permit(:name, :ceo)
    end
end
