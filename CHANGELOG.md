## [0.5.1]

- Fix `helm_test_logs` killing of child process which fails with error on Windows

## [0.5.0]

- Wait for any pod log only for a second (old behaviour can be reverted if `helm_upgrade_logs_log_start` ENV var is set) then use
  specific pod logs filtered by non failed status to filter. Fixing #4 and perhaps #2 

## [0.4.1]

- Ignore error if new environment variable `helm_upgrade_logs_ignore_child_error` is passed

## [0.4.0]

- Change to handle params before release name fixing #1

## [0.3.6]

- Handle parsing multiple error messages in `helm_upgrade_logs_error_msg` that are comma separated

## [0.3.5]

- Fix error where multiple processes being spawned to log the same pod

## [0.3.4]

- Only log to folder if `helm_upgrade_logs_error_msg` env variable set

## [0.3.3]

- Run force kill on processes to ensure they stop

## [0.3.2]

- ADO error and normal error don't need to both be displayed

## [0.3.1]

- Fix LOG folder parsed to check error message

## [0.3.0]

- Log output to a file in a folder `helm_upgrade_logs` as well as STDOUT
- If `helm_upgrade_logs_error_msg` is set then rethrow error after install finished. For AzureDevOps, setting
`helm_upgrade_logs_ado_error` to `true` will raise an error in the build

## [0.2.6]

- Don't log pods existing before an upgrade

## [0.2.5] 2022-04-21

- Return helm status code as script's status code

## [0.2.4] 2022-04-21

- Handle `n`, `--namespace` from helm command
- Exit if there is failure on helm command while trying to get logs

## [0.2.3] - 2022-04-20

- Configuration on initial wait for pods logs and subsequent wait limits

## [0.2.2] - 2022-04-20

- Wait for logs on each pod having a process for logging each pod

## [0.2.0] - 2022-04-20

- Monitoring pods don't filter managed by helm as some pods don't have that with selectorLabels

## [0.1.7] - 2022-04-20

- Monitor helm upgrade command and periodically reload getting logs when new pods appear

## [0.1.6] - 2022-04-17

- Add `helm_test_logs` exe to check logs during `helm test`
- Add `pod-running-timeout` of 300s to try and pick up logs that might take a while to appear

## [0.1.5] - 2022-04-16

- Only look at logs for release name

## [0.1.4] - 2022-04-16

- Wait for pods with logs to start before watching
