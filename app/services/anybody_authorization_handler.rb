# frozen_string_literal: true

# An example authorization handler used so that users can be verified against
# third party systems.
#
# You should probably rename this class and file to match your needs.
#
# If you need a custom form to be rendered, you can create a file matching the
# class name named "_form".
#
# Example:
#
#   A handler named Decidim::CensusHandler would look for its partial in:
#   decidim/census/form
#
# When testing your authorization handler, add this line to be sure it has a
# valid public api:
#
#   it_behaves_like "an authorization handler"
#
# See Decidim::AuthorizationHandler for more documentation.
class AnybodyAuthorizationHandler < Decidim::AuthorizationHandler
  # Define the attributes you need for this authorization handler. Attributes
  # are defined using Virtus.
  #
  # Example:
  # attribute :document_number, String
  # attribute :birthday, Date
  #
  # You can (and should) also define validations on each attribute:
  #
  # validates :document_number, presence: true
  # validate :custom_method_to_validate_an_attribute

  # The only method that needs to be implemented for an authorization handler.
  # Here you can add your business logic to check if the authorization should
  # be created or not, you should return a Boolean value.
  #
  # Note that if you set some validations and overwrite this method, then the
  # validations will not run, so it's easier to just remove this method and reite
  # your logic using ActiveModel validations.
  def valid?(*_)
    true
  end

  # If you need to store any of the defined attributes in the authorization you
  # can do it here.
  #
  # You must return a Hash that will be serialized to the authorization when
  # it's created, and available though authorization.metadata
  #
  # def metadata
  #   {}
  # end

  # If you need custom authorization logic, you can implement your own action
  # authorizer. In this case, it allows to set a list of valid postal codes for
  # an authorization.
  class ActionAuthorizer < Decidim::Verifications::DefaultActionAuthorizer
    attr_reader :allowed_emails

    # Overrides the parent class method, but it still uses it to keep the base behavior
    def authorize
      # Remove the additional setting from the options hash to avoid to be considered missing.
      @allowed_emails ||= options.delete("allowed_emails").to_s.split(",").map(&:strip)

      status_code, data = *super

      if allowed_emails.present?
        # Does not authorize users with different email addresses
        if status_code == :ok && !allowed_emails.member?(authorization.user.email)
          status_code = :unauthorized
          data[:fields] = { "email" => authorization.user.email }
        end

        # Adds an extra message for inform the user the additional restriction for this authorization
        data[:extra_explanation] = { key: "extra_explanation_restricted_emails",
                                     params: { scope: "decidim.authorization_handlers.anybody_authorization_handler" }}
      end

      [status_code, data]
    end

    # Adds the list of allowed postal codes to the redirect URL, to allow forms to inform about it
    #def redirect_params
    #  { "postal_codes" => allowed_postal_codes&.join("-") }
    #end
  end
end

