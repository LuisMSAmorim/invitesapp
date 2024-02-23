module UseCases
  module Administrators
    class Update

      def initialize(administrator_id, administrator_params)
        @administrator_id = administrator_id
        @administrator_params = administrator_params
      end

      def call
        user_administrator = User.find(@administrator_id)

        user_administrator.update(@administrator_params)

        user_administrator
      end
    end
  end
end
