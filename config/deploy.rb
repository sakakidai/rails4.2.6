lock "~> 3.17.1"

# アプリケーションの設定
set :application, "rails4.2.6"
set :deploy_to, '/var/www/rails4.2.6'

# レポジトリの設定
set :repo_url, "git@github.com:sakakidai/rails4.2.6.git"

# sharedディレクトリに入れるファイルを指定
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

# 保存するリリースの数
set :keep_releases, 5

# rbenvの設定
set :rbenv_type, :user
set :rbenv_ruby, '2.6.6'

# unicornの設定
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# sidekiqの設定
# set :init_system, :systemd # TODO: systemdに変更する
set :sidekiq_config, -> { "#{current_path}/config/sidekiq.yml" }
set :sidekiq_pid, -> { "#{shared_path}/tmp/pids/sidekiq.pid" }
set :sidekiq_tole, :worker

namespace :deploy do
  after :publishing, :restart

  # unicornを再起動するコマンド
  task :restart do
    invoke 'unicorn:restart'
  end
end
