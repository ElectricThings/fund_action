# frozen_string_literal: true

module ApplicationHelper

  def language_select_options(selected_languages = [])
    options_from_collection_for_select(
      LanguageList::COMMON_LANGUAGES.sort{|a,b|a.name <=> b.name},
      :iso_639_1, :name,
      selected_languages
    )
  end

end
