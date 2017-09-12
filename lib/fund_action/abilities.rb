# frozen_string_literal: true

module FundAction
  class Abilities
    include CanCan::Ability

    def initialize(user, _context)
      define_abilities if user.is_a?(Decidim::User)
    end

    def define_abilities
    end
  end
end

