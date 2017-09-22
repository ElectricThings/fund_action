module FundAction
  class InviteUser < Decidim::InviteUser

    private

    def invite_user
      @user = Decidim::User.new(
        name: form.name,
        email: form.email.downcase,
        organization: form.organization,
        invitation_limit: form.num_invites,
        admin: false,
        roles: []
      )
      @user.invite!(
        form.invited_by,
        invitation_instructions: form.invitation_instructions
      )
    end

  end
end
