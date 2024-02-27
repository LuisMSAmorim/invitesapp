module Companies
  class GetById
    def initialize(id)
      @id = id
    end

    def call
      Company.find_by(id: @id)
    end
  end
end
