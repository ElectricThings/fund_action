# frozen_string_literal: true

module FundAction
  class RemoveInvitation < Rectify::Command

    # user - The user to be updated.
    def initialize(user)
      @user = user
    end

    def call
      unless @user.invited_to_sign_up? and not @user.invitation_accepted?
        return broadcast(:invalid)
      end

      Decidim::User.transaction do
        if inviter = @user.invited_by
          # unused invitation do not count towards the limit
          inviter.increment_invitation_limit!
        end
        @user.destroy
      end

      broadcast(:ok)
    end

  end
end

