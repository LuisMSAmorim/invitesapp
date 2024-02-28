module Invites
  class GetAll < Get

    def initialize(current_user)
      @current_user = current_user
    end

    def call(params)
      if @current_user.admin?
        get_all_invites(params)
      else
        get_user_invites(params)
      end
    end

    private

    def get_all_invites(params)
      query = base_query
                .where(inactivated_at: nil)
                .all

      Builders::Invites::Filter.new(query)
                                .with_company_id(params[:company_id])
                                .with_name(params[:name])
                                .with_inactivation_date(params[:inactivation_date])
                                .call
    end

    def get_user_invites(params)
      query = base_query
                .where(inactivated_at: nil)
                .where(user_id: @current_user.id)

      Builders::Invites::Filter.new(query)
                                .with_company_id(params[:company_id])
                                .with_name(params[:name])
                                .with_inactivation_date(params[:inactivation_date])
                                .call
    end
  end
end
