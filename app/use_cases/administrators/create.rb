module Administrators
  class Create

    def initialize(params)
      @params = params
    end

    def call
      user_administrator = User.new(@params)

      user_administrator.role = :admin

      user_administrator.save

      user_administrator
    end
  end
end
