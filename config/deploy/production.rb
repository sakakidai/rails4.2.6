set :branch, :main
set :rails_env, 'production'
set :unicorn_rack_env, 'production'
set :user, 'ec2-user'

server 'rails4.2.6_prod_web1', user: 'ec2-user', roles: %w{app web db}
