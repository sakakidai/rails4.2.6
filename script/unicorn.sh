# !/bin/bash

set -eu
NAME="unicorn"
TIMEOUT=60
APP_ROOT="/Users/sakakidai/Documents/rails4.2.6_project/rails4.2.6"
PID="$APP_ROOT/tmp/pids/unicorn.pid"
CONFIG="$APP_ROOT/config/unicorn.rb"
RAILS_ENV="development"
CMD="bundle exec unicorn -D -c $CONFIG -E $RAILS_ENV"
action=$1

cd $APP_ROOT || exit 1

sig () {
    test -s "$PID" && kill -$1 `cat $PID`
}

case $action in
  start)
    sig 0 && echo >&2 "Already running $MANE" && exit 0
    $CMD
    ;;
  stop)
    sig QUIT && rm -f ${PID} && exit 0
    echo >&2 "Not running"
    ;;
esac

