set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '188.166.59.135', user: 'deploy', roles: %w{web app}

set :ssh_options, {
    forward_agent: true,
    auth_methods: %w(publickey)
}
