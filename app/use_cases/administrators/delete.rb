module UseCases
  module Administrators
    class Delete

      def initialize(administrator_id)
        @administrator_id = administrator_id
      end

      def call
        user_administrator = User.find(@administrator_id)

        user_administrator.destroy
      end
    end
  end
end
