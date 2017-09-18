source "https://rubygems.org"

ruby '2.4.1'

gem "decidim", path: '../decidim'

gem 'uglifier', '>= 1.3.0'

gem 'rack-attack'
gem 'country_select', require: 'country_select_without_sort_alphabetical'
gem 'language_list'

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev", path: '../decidim'
  #gem 'faker', '~> 1.8.4'
end

group :development do
  gem 'puma', '~> 3.0'
  gem 'web-console'
  gem 'listen', '~> 3.1.0'
  gem 'letter_opener_web', '~> 1.3.0'

  gem 'capistrano'
  gem 'capistrano-rails', require: false
  gem 'capistrano-chruby', require: false

  gem 'rbnacl', '< 5.0', '>= 3.2.0'
  gem 'rbnacl-libsodium'
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
end

group :production do
  gem 'daemons'
  gem 'delayed_job_active_record'
  gem 'syslog_logger', github: 'jkraemer/syslog_logger'
  gem 'unicorn'
  gem 'dalli'
  gem 'airbrake'
end

