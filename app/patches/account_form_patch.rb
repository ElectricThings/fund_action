module AccountFormPatch
  def self.apply
    unless Decidim::AccountForm < self
      Decidim::AccountForm.prepend self
      Decidim::AccountForm.class_eval do
        attribute :about_me
        attribute :areas_of_interest
        attribute :can_contribute
        attribute :country
        attribute :gender
        attribute :languages
        attribute :other_area_of_interest
      end
    end
  end

  def map_model(user)
    super
    if profile = user.profile
      self.about_me = profile['about_me']
      self.areas_of_interest = profile['areas_of_interest']
      self.can_contribute = profile['can_contribute']
      self.country = profile['country']
      self.gender = profile['gender']
      self.languages = profile['languages']
      self.other_area_of_interest = profile['other_area_of_interest']
    end
  end

end

