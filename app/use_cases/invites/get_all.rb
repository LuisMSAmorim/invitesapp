module Invites
  class GetAll < Get

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
      base_query
        .where(inactivated_at: nil)
        .all
    end

    def get_user_invites
      base_query
        .where(inactivated_at: nil)
        .where(user_id: @current_user.id)
    end
  end
end
