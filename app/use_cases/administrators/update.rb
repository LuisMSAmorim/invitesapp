module Administrators
  class Update
    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      user_administrator = User.find_by!(id: @id, role: :admin)

      user_administrator.update(@params)

      user_administrator
    end
  end
end
