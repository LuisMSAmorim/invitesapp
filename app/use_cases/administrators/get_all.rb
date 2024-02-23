module UseCases
  module Administrators
    class GetAll

      def call
        User.where(role: :admin)
      end
    end
  end
end
