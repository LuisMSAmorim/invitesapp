module Companies
  class Delete

    def initialize(id)
      @id = id
    end

    def call
      company = Company.find_by!(id: @id)

      company.destroy
    end
  end
end
