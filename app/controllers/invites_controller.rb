class InvitesController < ApplicationController

  def index
    @invites = Invites::GetAll.new(current_user).call
  end

  def show
    @invite = Invites::GetById.new(params[:id], current_user).call
  end

  def edit
    @invite = Invites::GetById.new(params[:id], current_user).call
  end

  def update
    @invite = Invites::Update.new(params[:id], invite_params).call

    respond_to do |format|
      if @invite.update(invite_params)
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

  private

  def invite_params
    params.require(:invite).permit(:title, :description, :date, :inactivated_at, :company_id, :user_id)
  end
end
