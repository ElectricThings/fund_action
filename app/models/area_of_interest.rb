# frozen_string_literal: true

class AreaOfInterest

  # Do not change the keys of this hash, they are referenced by
  # user.profile.areas_of_interest.
  ALL = {
    'human_rights' => 'Human rights & anti-discrimination (gender, race, minorities, disabilty etc.)',
    'climate_justice' => 'Climate justice & environment',
    'alt_economies' => 'Alternative economies (commons, circular economy, transition town etc.)',
    'alt_media' => 'Alternative media, arts & culture',
    'digital_activism' => 'Digital activism',
    'democratic_innovation' => 'Democratic innovation & civic education',
    'migration' => 'Migration',
    'civil_rights' => 'Civil, political & social rights',
  }.freeze

  def self.to_a
    ALL.to_a
  end

  def self.for(name)
    ALL[name]
  end

end
