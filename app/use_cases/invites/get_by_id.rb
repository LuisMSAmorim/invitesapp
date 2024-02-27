module Invites
  class GetById

    def initialize(id, current_user)
      @id = id
      @current_user = current_user
    end

    def call
      if @current_user.admin?
        get_invite
      else
        get_user_invite
      end
    end

    private

    def get_invite
      Invite.find_by!(id: @id)
    end

    def get_user_invite
      Invite.find_by!(id: @id, user_id: @current_user.id)
    end
  end
end
