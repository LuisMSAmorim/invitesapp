module Invites
  class Delete

    def initialize(id)
      @id = id
    end

    def call
      invite = Invite.find_by!(id: @id)

      invite.destroy
    end
  end
end
