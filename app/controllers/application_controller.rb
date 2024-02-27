class ApplicationController < ActionController::Base

  protected

  def authorize_administrator!
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action"
    end
  end
end
