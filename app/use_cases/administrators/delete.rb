module UseCases
  module Administrators
    class Delete

      def initialize(id)
        @administrator_id = id
      end

      def call
        user_administrator = User.find(@administrator_id)

        user_administrator.destroy
      end
    end
  end
end
