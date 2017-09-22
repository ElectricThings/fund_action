# frozen_string_literal: true

module FundAction
  class Abilities
    include CanCan::Ability

    def initialize(user, _context)
      define_user_abilities(user) if user.is_a?(Decidim::User)
    end

    def define_user_abilities(user)
      can :invite, Decidim::User do |u|
        u.invited_by == user
      end
      can :delete, Decidim::User do |u|
        u.invited_to_sign_up? and
          u.invited_by == user and
          !u.invitation_accepted?
      end
    end
  end
end

