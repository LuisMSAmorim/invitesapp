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
      Invite
      .select(selected_columns)
      .left_joins(:company)
      .left_joins(:user)
      .all
    end

    def get_user_invites
      Invite
        .select(selected_columns)
        .left_joins(:company)
        .left_joins(:user)
        .where(user_id: @current_user.id)
      end

    def selected_columns
      [
        'invites.*',
        'companies.*',
        'users.id as user_id',
        'users.email as user_email'
      ]
    end
  end
end
