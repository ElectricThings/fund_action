set :deploy_to, "/srv/webapps/#{fetch :application}"
set :branch, 'master'

server 'app02.jkraemer.net', user: 'deploy', roles: %w{web app}
server 'wintermute.jkraemer.net', user: 'deploy', roles: %w{web app db}

# set :ssh_options, {
#   keys: %w(/home/jk/.ssh/id_ed25519),
#   forward_agent: true,
#   auth_methods: %w(publickey)
# }
# 
