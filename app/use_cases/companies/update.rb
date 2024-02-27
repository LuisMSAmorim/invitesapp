module Companies
  class Update

    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      company = Company.find_by!(id: @id)

      company.update(@params)

      company
    end
  end
end
