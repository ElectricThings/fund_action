module UpdateAccountPatch

  def self.apply
    Decidim::UpdateAccount.prepend self unless Decidim::UpdateAccount < self
  end

  def update_personal_data
    super
    @user.profile = {
      country: @form.country,
      languages: @form.languages.reject(&:blank?),
      about_me: @form.about_me
    }
  end
end

