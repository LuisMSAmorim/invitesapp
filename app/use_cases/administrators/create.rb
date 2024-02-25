module Administrators
  class Create

    def initialize(params)
      @administrator_params = params
    end

    def call
      user_administrator = User.new(@administrator_params)

      user_administrator.role = :admin

      if user_administrator.save
        user_administrator
      else
        user_administrator.errors
      end
    end
  end
end

