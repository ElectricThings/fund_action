module FundAction
  class Permissions < Decidim::DefaultPermissions

    def permissions
      return permission_action unless permission_action.scope == :public
      return permission_action unless user

      invitation_action?

      permission_action
    end

    private

    def invitation_action?
      return unless permission_action.subject == :invitations

      case permission_action.action
      when :destroy, :resend
        if u = invitation_user and
             u.invited_to_sign_up? and
             u.invited_by == user and
             !u.invitation_accepted?
          allow!
        end
      when :create
        allow!
      end
    end

    def invitation_user
      context.fetch(:user, nil)
    end

  end
end
