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

      @user.destroy
      broadcast(:ok)
    end

  end
end

