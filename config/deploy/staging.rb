set :deploy_to, "/srv/webapps/#{fetch :application}_stage"
set :script_postfix, "_stage"
set :rails_env, :production
set :branch, 'staging'

server 'app02.jkraemer.net', user: 'deploy', roles: %w{web app}
server 'wintermute.jkraemer.net', user: 'deploy', roles: %w{web app db}

