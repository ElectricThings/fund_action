# frozen_string_literal: true

module ApplicationHelper

  def language_select_options(selected_languages = [])
    options_from_collection_for_select(
      LanguageList::COMMON_LANGUAGES.sort{|a,b|a.name <=> b.name},
      :iso_639_1, :name,
      selected_languages
    )
  end

  def area_of_interest_select_options(selected_areas_of_interest = [])
    options_from_collection_for_select(
      AreaOfInterest.to_a, :first, :last, selected_areas_of_interest
    )
  end

end
