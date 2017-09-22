# frozen_string_literal: true
#
module FundAction
  class InviteUsers < Rectify::Command

    def initialize(form, user)
      @form = form
      @user = user
    end

    def call
      successes = []
      errors = []

      unless @form.valid?
        return broadcast :invalid, successes, errors
      end

      # only administrators can give invitation credit to invitees
      num_invites = @user.admin? ? @form.num_invites : 0

      @form.each_email do |name, email|
        form = form(FundAction::InviteUserForm).
          from_params user: { name: name, email: email,
                              num_invites: num_invites }

        FundAction::InviteUser.(form) do
          on(:ok) do
            successes << email
          end
          on(:invalid) do
            errors << email
          end
        end
      end

      if errors.blank?
        broadcast :ok, successes
      else
        broadcast :invalid, successes, errors
      end
    end

  end
end
