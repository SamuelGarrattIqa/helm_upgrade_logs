## [0.1.7] - 2022-04-20

- Monitor helm upgrade command and periodically reload getting logs when new pods appear

## [0.1.6] - 2022-04-17

- Add `helm_test_logs` exe to check logs during `helm test`
- Add `pod-running-timeout` of 300s to try and pick up logs that might take a while to appear

## [0.1.5] - 2022-04-16

- Only look at logs for release name

## [0.1.4] - 2022-04-16

- Wait for pods with logs to start before watching
