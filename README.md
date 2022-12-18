## README

### capistranoのタスクの実行順を確認

```
$ bundle exec cap development deploy --trace --dry-run 2>&1 | grep -E "\(first_time\)"
```
