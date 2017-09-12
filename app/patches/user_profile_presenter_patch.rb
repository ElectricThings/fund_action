module UserProfilePresenterPatch
  def self.apply
    Decidim::UserProfilePresenter.prepend self unless Decidim::UserProfilePresenter < self
  end


  def languages
    if codes = profile_attr('languages')
      codes.map{ |l| LanguageList::LanguageInfo.find(l)&.name }.compact
    end
  end

  def country
    if country_code = profile_attr('country') and
       country = ISO3166::Country[country_code]

      country.translations[I18n.locale.to_s] || country.name
    end
  end

  def about_me
    profile_attr 'about_me'
  end

  private

  def profile_attr(name)
    user.profile[name] if user.profile
  end

end
