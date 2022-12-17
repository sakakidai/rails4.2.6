lock "~> 3.17.1"

# アプリケーションの設定
set :application, "rails4.2.6"
set :deploy_to, '/var/www/rails4.2.6'

# レポジトリの設定
set :repo_url, "git@github.com:sakakidai/rails4.2.6.git"
set :scm, :git

# sharedディレクトリに入れるファイルを指定
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

# 保存するリリースの数
set :keep_releases, 5

# unicornの設定
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }

# unicornを再起動するコマンド
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end