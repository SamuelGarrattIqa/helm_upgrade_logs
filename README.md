# Helm Upgrade Logs

Idea is to show logs of pods and events while doing a kubernetes helm install or upgrade.

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

This gem is purely about an `exe` to wrap around `helm` commands and to log helpful commands.
Once installed, install/upgrade a helm chart with

```bash
helm_upgrade_logs --install redis bitnami/redis --set auth.enabled=false --version 14.0.2 --wait
```

After the `helm_upgrade_logs` command put any options that would normally add after `helm upgrade`.

To test a chart showing it logs, in a similar way run
```bash
helm_test_logs redis
```

This also has a bash script which can be used directly. E.g., to install `nginx` from the chart `bitnami/nginx`.

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
