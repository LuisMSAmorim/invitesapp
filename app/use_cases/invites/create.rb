module Invites
  class Create

    def initialize(params)
      @params = params
    end

    def call
      invite = Invite.new(params)

      invite.save

      invite
    end
  end
end
