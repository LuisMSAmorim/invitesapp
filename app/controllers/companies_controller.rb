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

    respond_to do |format|
      if @company.valid?
        format.html { redirect_to companies_path, notice: I18n.t('views.companies.update.success') }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Companies::Create.new(company_params).call

    respond_to do |format|
      if @company.persisted?
        format.html { redirect_to companies_path, notice: I18n.t('views.companies.create.success') }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Companies::Delete.new(params[:id]).call
    redirect_to companies_path, notice: I18n.t('views.companies.destroy.success')
  end

  private

    def company_params
      params.require(:company).permit(:name, :ceo)
    end
end
