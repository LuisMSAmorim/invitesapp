module Administrators
  class Update

    def initialize(id, params)
      @administrator_id = id
      @administrator_params = params
    end

    def call
      user_administrator = User.find_by!(id: @administrator_id, role: :admin)

      user_administrator.update(@administrator_params)

      user_administrator
    end
  end
end
