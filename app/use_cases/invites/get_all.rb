module Invites
  class GetAll

    def initialize(current_user)
      @current_user = current_user
    end

    def call
      if @current_user.admin?
        get_all_invites
      else
        get_user_invites
      end
    end

    private

    def get_all_invites
      Invite.all
    end

    def get_user_invites
      Invite.where(user_id: @current_user.id)
    end
  end
end
