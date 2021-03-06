# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FundAction
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Berlin'

    config.to_prepare do
      #Dir[Rails.root/'app/patches/**/*.rb'].each do |file|
      #  require_dependency file
      #end

      AccountFormPatch.apply
      UpdateAccountPatch.apply
      UserPatch.apply
      UserPresenterPatch.apply
    end



  end
end


