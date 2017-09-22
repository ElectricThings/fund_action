# frozen_string_literal: true
#
module FundAction
  class InviteUsers < Rectify::Command

    def initialize(form)
      @form = form
    end

    def call
      successes = []
      errors = []
      @form.each_email do |name, email|
        form = form(FundAction::InviteUserForm).
          from_params user: { name: name, email: email }

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
