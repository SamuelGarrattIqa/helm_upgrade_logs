## [0.2.6]

-- Don't log pods existing before an upgrade

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
