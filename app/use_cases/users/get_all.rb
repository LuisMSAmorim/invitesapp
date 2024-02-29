module Users
  class GetAll
    def call
      User.where(role: :user)
    end
  end
end
