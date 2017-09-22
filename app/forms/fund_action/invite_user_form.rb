module FundAction
  class InviteUserForm < Decidim::Form
    mimic :user

    attribute :email, String
    attribute :name, String
    attribute :emails, String
    attribute :num_invites, Fixnum

    validates :email, presence: true, if: ->(r){r.emails.blank?}
    validates :name, presence: true, if: ->(r){r.emails.blank?}

    validates :emails, presence: true, if: ->(r){r.email.blank?}
    validates :emails, with: :check_emails_format
    validates :num_invites, numericality: true

    validate :email_uniqueness

    def each_email
      if multiple?
        emails.lines.each do |line|
          if line.present?
            name, email = line.split(',').map(&:strip)
            yield [name, email.downcase]
          end
        end
      else
        yield [name.strip, email.strip]
      end
    end

    def num_invites
      super || 0
    end

    def multiple?
      emails.present?
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

    def check_emails_format
      if emails.present? and emails.lines.any?{|l| l.present? and l.split(',').size != 2}
        errors.add :emails, :invalid
      end
    end

    def email_uniqueness
      errors.add(:email, :taken) if email.present? && organization.users.where(email: email).exists?
    end
  end
end
