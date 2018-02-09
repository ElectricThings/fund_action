module MemberPresenterPatch
  def self.apply
    Decidim::Members::MemberPresenter.prepend self unless Decidim::Members::MemberPresenter < self
  end

  def public_email?
    profile_attr('public_email') == '1'
  end

  def email
    user.email
  end

  def languages
    if codes = profile_attr('languages')
      codes.map{ |l| LanguageList::LanguageInfo.find(l)&.name }.compact
    end
  end

  def areas_of_interest
    if areas = profile_attr('areas_of_interest')
      areas = areas.map{ |name| AreaOfInterest.for(name) }.compact
      if other = other_area_of_interest
        areas << other
      end
      areas
    end
  end

  def other_area_of_interest
    profile_attr('other_area_of_interest').presence
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

  def gender
    profile_attr 'gender'
  end

  def can_contribute
    profile_attr 'can_contribute'
  end

  def cultural_background
    profile_attr 'cultural_background'
  end

  private

  def profile_attr(name)
    user.profile[name] if user.profile
  end

end
