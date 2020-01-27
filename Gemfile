source "https://rubygems.org"

ruby '2.5.1'
gem "rails", "~> 5.2.1.1"

#gem "decidim", path: '../decidim'
#gem "decidim-members", path: '../decidim-members'
gem "decidim", github: 'electricthings/decidim', branch: 'fundaction/0.13-stable'
gem "decidim-calendar", git: "https://github.com/alabs/decidim-module-calendar", branch: "0.13-stable"
gem "decidim-consultations"
gem 'decidim-members', github: 'electricthings/decidim-members'

gem 'uglifier', '>= 1.3.0'

gem 'rack-attack'

gem 'country_select', "~> 3.1", require: 'country_select_without_sort_alphabetical'
gem 'language_list'
gem 'therubyracer'
gem 'doorkeeper', '~> 4.4'

gem 'rack', '>= 2.0.8'

group :development, :test do
  gem 'byebug', platform: :mri
  #gem "decidim-dev", path: '../decidim'
  #gem "decidim-dev", github: 'electricthings/decidim', branch: 'fundaction/0.13-stable'
  #gem 'faker', '~> 1.8.4'
end

group :development do
  gem 'faker'
  gem 'puma', '>= 3.12.2'
  gem 'web-console'
  gem 'listen', '~> 3.1.0'
  gem 'letter_opener_web', '~> 1.3.0'

  gem 'capistrano', '~> 3.10.0'
  gem 'capistrano-rails', require: false
  gem 'capistrano-chruby', require: false

  gem 'rbnacl', '< 5.0', '>= 3.2.0'
  gem 'rbnacl-libsodium'
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'ed25519', '>= 1.2', '< 2.0'
end

group :production do
  gem 'daemons'
  gem 'delayed_job_active_record'
  gem 'unicorn'
  gem 'dalli'
  gem 'airbrake', "~> 7.3"
end

