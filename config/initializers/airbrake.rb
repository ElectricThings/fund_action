if defined?(Airbrake)

  require 'airbrake_filter'

  Airbrake.configure do |config|
    config.project_id = 1234
    config.project_key = CGI.escape({
      project: 'fund-action',
      tracker: 'Application Error',
      api_key: Rails.application.secrets.redmine_api_key,
      assigned_to: 'jk',
      priority: 3,
      environment: 'production'
    }.to_json)
    config.host = 'https://rm.jkraemer.net'
    config.root_directory = Rails.root.to_s
    config.environment = Rails.env
    config.ignore_environments = %w(test development)

    config.blacklist_keys |= Rails.application.config.filter_parameters.map(&:to_s)
  end

  Airbrake.add_filter AirbrakeFilter.new

end
