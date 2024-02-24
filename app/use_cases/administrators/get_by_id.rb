module UseCases
  module Administrators
    class GetById
      def call(id)
        Administrator.find(id)
      end
    end
  end
end
