module Invites
  class Update
    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      invite = Invite.find_by!(id: @id)

      invite.update(@params)

      invite
    end
  end
end
