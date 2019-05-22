set :deploy_to, "/srv/webapps/#{fetch :application}_stage"
set :script_postfix, "_stage"
set :rails_env, :production
set :branch, 'alabs-feature/decidim-calendar'

server 'case.jkraemer.net', user: 'deploy', roles: %w{web app db}

# set :ssh_options, {
#   keys: %w(/home/jk/.ssh/id_ed25519),
#   forward_agent: true,
#   auth_methods: %w(publickey)
# }
# 
