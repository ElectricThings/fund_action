source "https://rubygems.org"

ruby '2.4.1'

gem "decidim", "0.4.4"

gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev", "0.4.4"
  #gem 'faker', '~> 1.8.4'
end

group :development do
  gem 'puma', '~> 3.0'
  gem 'web-console'
  gem 'listen', '~> 3.1.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener_web', '~> 1.3.0'

  gem 'capistrano'
end

group :production do
  gem 'daemons'
  gem 'delayed_job_active_record'
  gem 'unicorn'
  gem 'dalli'
end
