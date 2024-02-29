module Companies
  class Create
    def initialize(params)
      @params = params
    end

    def call
      company = Company.new(@params)

      company.save

      company
    end
  end
end
