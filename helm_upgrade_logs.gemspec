# frozen_string_literal: true

require_relative "lib/helm_upgrade_logs/version"

Gem::Specification.new do |spec|
  spec.name          = "helm_upgrade_logs"
  spec.version       = HelmUpgradeLogs::VERSION
  spec.authors       = ["Samuel Garratt"]
  spec.email         = ["samuel.garratt@sentify.co"]

  spec.summary       = "Basic wrapper around helm and kubectl to allow easy debugging of a helm release."
  spec.description   = "Basic wrapper around helm and kubectl to allow easy debugging of a helm release. All arguments after a usual helm upgrade are used as normal"
  spec.homepage      = "https://gitlab.com/samuel-garratt/helm_upgrade_logs"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://gitlab.com/samuel-garratt/helm_upgrade_logs"
  spec.metadata["changelog_uri"] = "https://gitlab.com/samuel-garratt/helm_upgrade_logs/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:spec)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
