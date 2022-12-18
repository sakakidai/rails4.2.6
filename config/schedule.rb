# unicornとはプロセスで起動し、おそらく、このファイルの読み込みのみでclockworkのプロセスが動いている。
# 定数が初期化されないため、bootとenvironmentをrequireする。
require_relative './boot'
require_relative './environment'

include Clockwork

# everyの実行時間は起動時間に依存する？
every(10.minutes, 'test_worker.job') do
  ::TestWorker.perform_async(30)
end
