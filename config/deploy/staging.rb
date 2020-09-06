set :deploy_to, "/srv/webapps/#{fetch :application}_stage"
set :script_postfix, "_stage"
set :rails_env, :production
set :branch, 'feature/upgrade-0.22'

server 'app01.jkraemer.net', user: 'deploy', roles: %w{web app}
server 'app03.jkraemer.net', user: 'deploy', roles: %w{web app db}

