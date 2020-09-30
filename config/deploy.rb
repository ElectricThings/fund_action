# config valid only for current version of Capistrano
lock "3.10.2"

set :application, "fundaction"
set :repo_url, "git@code.jkraemer.net:fund_action.git"

set :chruby_ruby, "ruby-2.6.6"

set :bundle_jobs, 2
set :bundle_binstubs, -> { shared_path.join("bin") }

set :pty, true

append :linked_files, "config/database.yml", "config/secrets.yml", "config/puma.rb", "config/smtp_settings.yml"
append :linked_dirs, "log", "tmp", ".bundle"
append :linked_links, 'public/uploads', 'files'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :keep_releases, 5
set :script_name, ->{"#{fetch :application}#{fetch :script_postfix}"}

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "/bin/systemctl restart #{fetch :script_name}_puma.service"
      sudo "/bin/systemctl restart #{fetch :script_name}_delayed_job"
    end
  end

  after :publishing, :restart
  after :finishing, :cleanup
end

