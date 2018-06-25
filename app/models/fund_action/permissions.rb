module FundAction
  class Permissions < Decidim::DefaultPermissions

    def permissions

      unless user and user.is_a?(Decidim::User)
        permission_action.disallow!
        return permission_action
      end

      unless permission_action.scope == :global and
             permission_action.subject == :invitations

        return permission_action
      end

      case permission_action.action
      when :destroy, :resend
        if u = invitation_user and
             u.invited_to_sign_up? and
             u.invited_by == user and
             !u.invitation_accepted?
          permission_action.allow!
        end
      when :create
        permission_action.allow!
      end


      return permission_action
    end

    def invitation_user
      context.fetch(:user, nil)
    end

  end
end
