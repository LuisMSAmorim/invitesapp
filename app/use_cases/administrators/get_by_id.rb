module Administrators
  class GetById
    def call(id)
      User.find_by!(id: id, role: :admin)
    end
  end
end
