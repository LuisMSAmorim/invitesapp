module Administrators
  class GetById
    def initialize(id)
      @id = id
    end

    def call
      User.find_by!(id: @id, role: :admin)
    end
  end
end
