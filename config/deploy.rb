# config valid only for current version of Capistrano
lock "3.9.1"

set :application, "fund_action"
set :repo_url, "git@code.jkraemer.net:fund_action.git"

set :chruby_ruby, 'ruby-2.4.1'

set :bundle_jobs, 2
set :bundle_binstubs, -> { shared_path.join('bin') }

set :deploy_to, "/srv/webapps/fund_action"

set :pty, true

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp", "vendor/bundle", "files", 'public/uploads'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "/etc/init.d/unicorn reload fund_action"
      sudo "/etc/init.d/delayed_job restart fund_action"
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

end

