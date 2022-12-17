# Doc: https://autovice.jp/articles/146
# Doc: https://tachesimazzoca.github.io/wiki/rails3/unicorn.html
rails_root = File.expand_path('../../', __FILE__)

ENV['BUNDLE_GEMFILE'] = rails_root + '/Gemfile'

worker_processes 2
timeout 300

# Unicornの起動コマンドが実行されるディレクトリ
working_directory rails_root
pid "#{rails_root}/tmp/pids/unicorn.pid"
listen 3000
listen "#{rails_root}/tmp/sockets/unicorn.sock"
stdout_path "#{rails_root}/log/unicorn_stdout.log"
stderr_path "#{rails_root}/log/unicorn_stderr.log"

# Unicornの再起動をダウンタイムなしで行う。この設定によりアプリケーションがダウンすることなくデプロイすることが出来る。（ホットデプロイ）
# ※ kill -USE2 PID
# 1. 現在のプロセスIDが保存してあるunicorn.pidをunicorn.pid.oldbinにコピー
# 2. 新しいUnicornのプロセスを起動（新しいプロセスIDをunicorn.pidに保存）
# 3. before_forkを実施して、unicorn.pid.oldbinを参照して古いプロセスを停止する
preload_app true

# フォークが行われる前の処理(新しいプロセスの起動が完了すると処理が開始する)
before_fork do |server, worker|
  # UnicornとActive Recordの切断
  ActiveRecord::Base.connection.disconnect!

  # 現在のプロセスIDが保存してあるunicorn.pidをunicorn.pid.oldbinにコピー
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      # greceful shotdownで古いプロセスを停止する
      # Process.kill "OUIT", File.read(old_pid).to_i
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.errror e
    end
  end
end

# フォークが行われた後の処理
after_fork do |server, worker|
  # UnicornとActive Recordの接続
  defined?(ActiveRecort::Base) && ActiveRecord::Base.establish_connection
end
