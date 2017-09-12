module AccountFormPatch
  def self.apply
    unless Decidim::AccountForm < self
      Decidim::AccountForm.prepend self
      Decidim::AccountForm.class_eval do
        attribute :about_me
        attribute :country
        attribute :languages
      end
    end
  end

  def map_model(user)
    super
    if profile = user.profile
      self.about_me  = profile['about_me']
      self.country   = profile['country']
      self.languages = profile['languages']
    end
  end

end

