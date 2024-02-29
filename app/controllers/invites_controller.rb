class InvitesController < ApplicationController
  before_action :set_users, only: %i[new edit update create]
  before_action :set_companies, only: %i[new edit update create index]
  before_action :authenticate_user!
  before_action :authorize_administrator!, except: %i[index show]

  def index
    @invites = Invites::GetAll.new(current_user).call(filter_params)
  end

  def show
    @invite = Invites::GetById.new(params[:id], current_user).call
  end

  def edit
    @companies = Companies::GetAll.new.call
    @users = Users::GetAll.new.call
    @invite = Invites::GetById.new(params[:id], current_user).call
  end

  def update
    @invite = Invites::Update.new(params[:id], invite_params).call

    respond_to do |format|
      if @invite.valid?
        format.html { redirect_to invite_url(@invite), notice: I18n.t('views.invites.update.success') }
        format.json { render :show, status: :ok, location: @invite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invites::Create.new(invite_params).call

    respond_to do |format|
      if @invite.save
        format.html { redirect_to invite_url(@invite), notice: I18n.t('views.invites.create.success') }
        format.json { render :show, status: :created, location: @invite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Invites::Delete.new(params[:id]).call

    respond_to do |format|
      format.html { redirect_to invites_url, notice: I18n.t('views.invites.destroy.success') }
      format.json { head :no_content }
    end
  end

  def inactivate
    @invite = Invites::Update.new(params[:id], { inactivated_at: Date.today }).call

    respond_to do |format|
      format.html { redirect_to invites_url, notice: I18n.t('views.invites.inactivate.success') }
      format.json { head :no_content }
    end
  end

  private

  def set_users
    @users = Users::GetAll.new.call
  end

  def set_companies
    @companies = Companies::GetAll.new.call
  end

  def filter_params
    params.permit(:title, :inactivation_date, :company_id)
  end

  def invite_params
    params.require(:invite).permit(:title, :description, :date, :inactivated_at, :company_id, :user_id)
  end
end
