module Invites
  class Get
    def call
      raise NotImplementedError
    end

    protected

    def base_query
      Invite
        .select(selected_columns)
        .left_joins(:company)
        .left_joins(:user)
    end

    def selected_columns
      [
        'invites.*',
        'companies.id as company_id',
        'companies.name as company_name',
        'companies.ceo as company_ceo',
        'users.id as user_id',
        'users.email as user_email'
      ]
    end
  end
end
