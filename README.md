# Helm Upgrade Logs

Idea is to show logs of pods and events while doing a kubernetes helm install or upgrade.

> This has only been tested on linux. More more would be needed to run script properly on Windows

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'helm_upgrade_logs'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install helm_upgrade_logs

## Usage

This gem is purely about an `exe` to wrap around `helm` commands and to log events and pod logs that happen as
part of that release while it is being released. 

Once installed, install/upgrade a helm chart with

```bash
helm_upgrade_logs --install redis bitnami/redis --set auth.enabled=false --version 14.0.2 --wait
```

After the `helm_upgrade_logs` command put any options that would normally add after `helm upgrade`.

This library waits for logs to start in pods for 90 seconds or controlled by environment variable `helm_upgrade_logs_log_start`.
After that it waits 35 seconds for logs to start in pods after the first one. 
This is controlled by environment variable `helm_upgrade_logs_pod_start`

Logs are pushed to STDOUT and also to files in a folder `helm_upgrade_logs`. 
The ENV variable `helm_upgrade_logs_error_msg` can be set to throw an error at the end for a certain string
contained in the logs like `ERROR`. The `helm_upgrade_logs_ado_error` can be set to raise a signal to Azure
Dev Ops to throw an error in the build.

To test a chart showing it logs, in a similar way run
```bash
helm_test_logs redis
```

### Aside bash script

This also has a bash script which can be used directly although it will probably not work on CI
and also does not close background processes so not ideal.

However if you do want to try it, to install `nginx` from the chart `bitnami/nginx` run

```
curl -s https://raw.githubusercontent.com/SamuelGarrattIqa/helm_upgrade_logs/main/bin/helm_upgrade_logs.sh | bash -s -- --install nginx bitnami/nginx
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SamuelGarrattIqa/helm_upgrade_logs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/SamuelGarrattIqa/helm_upgrade_logs/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HelmUpgradeLogs project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SamuelGarrattIqa/helm_upgrade_logs/blob/main/CODE_OF_CONDUCT.md).
