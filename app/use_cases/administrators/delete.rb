module Administrators
  class Delete

    def initialize(id)
      @administrator_id = id
    end

    def call
      user_administrator = User.find_by!(id: @administrator_id, role: :admin)

      user_administrator.destroy
    end
  end
end
