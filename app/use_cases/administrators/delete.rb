module Administrators
  class Delete

    def initialize(id)
      @id = id
    end

    def call
      user_administrator = User.find_by!(id: @id, role: :admin)

      user_administrator.destroy
    end
  end
end
