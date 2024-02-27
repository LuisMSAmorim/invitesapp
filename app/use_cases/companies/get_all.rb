module Companies
  class GetAll

    def call
      Company.all
    end
  end
end
