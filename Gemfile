source "https://rubygems.org"

ruby '~> 2.6.6'
gem "rails", ">= 5.2.6.3", "< 6.0"

#gem "decidim", path: '../decidim'
gem "decidim", git: 'https://github.com/electricthings/decidim', branch: '6ae5ce8a8'
gem "decidim-calendar", git: "https://github.com/electricthings/decidim-module-calendar", branch: "master"
gem "decidim-consultations"

#gem "decidim-members", path: '../decidim-members'
gem 'decidim-members', git: 'https://github.com/electricthings/decidim-members'

gem 'uglifier', '>= 1.3.0'

gem 'rack-attack'

gem 'country_select', "~> 3.1", require: 'country_select_without_sort_alphabetical'
gem 'language_list'
gem 'therubyracer'

gem 'sprockets', '< 4.0'

gem 'rack', '>= 2.0.8'

gem 'nokogiri', ">= 1.11.4"

# GHSA-p4x4-rw2p-8j8m
gem "sanitize", ">= 5.2.1"

gem 'kaminari', '~> 1.2.1'

# GHSA-g6wq-qcwm-j5g2
gem "websocket-extensions", ">= 0.1.5"

group :development, :test do
  gem 'byebug', platform: :mri
  #gem "decidim-dev", path: '../decidim'
  #gem "decidim-dev", github: 'electricthings/decidim', branch: 'fundaction/0.13-stable'
  #gem 'faker', '~> 1.8.4'
end

gem 'puma', '>= 4.3.8'


#  CVE-2021-32740
gem "addressable", ">= 2.8.0"

group :development do
  gem 'faker'
  gem 'web-console'
  gem 'listen', '~> 3.1.0'
  gem 'letter_opener_web', '~> 1.3.0'

  gem 'capistrano', '~> 3.10.0'
  gem 'capistrano-rails', require: false
  gem 'capistrano-chruby', require: false
  gem 'capistrano-cloud-stuff', require: false, git: 'git@code.jkraemer.net:jk/capistrano-cloud-stuff'

  gem 'rbnacl', '< 5.0', '>= 3.2.0'
  gem 'rbnacl-libsodium'
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'ed25519', '>= 1.2', '< 2.0'
end

group :production do
  gem 'puma-plugin-systemd'
  gem 'puma_worker_killer'
  gem 'connection_pool'
  gem 'delayed_job_active_record'
  gem 'daemons'
  gem 'dalli'
  gem 'airbrake', "~> 7.3"
end

