module FundAction
  class InviteUserForm < Decidim::Form
    mimic :user

    attribute :email, String
    attribute :name, String
    attribute :emails, String

    validates :email, presence: true, if: ->(r){r.emails.blank?}
    validates :name, presence: true, if: ->(r){r.emails.blank?}

    validates :emails, presence: true, if: ->(r){r.email.blank?}

    validate :email_uniqueness

    def each_email
      if emails.present?
        emails.lines.each do |line|
          name, email = line.split ','
          yield [name.strip, email.strip.downcase]
        end
      else
        yield [name.strip, email.strip]
      end
    end

    def email
      super&.downcase
    end

    def organization
      current_organization
    end

    def invited_by
      current_user
    end

    def invitation_instructions
      'invited_by_user'
    end

    private

    def email_uniqueness
      errors.add(:email, :taken) if email.present? && organization.users.where(email: email).exists?
    end
  end
end
