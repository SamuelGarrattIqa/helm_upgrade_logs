# frozen_string_literal: true

RSpec.describe HelmUpgradeLogs do
  it "has a version number" do
    expect(HelmUpgradeLogs::VERSION).not_to be nil
  end

  it "can extract namespace from args" do
    argv = %w[helm upgrade --install nginx -n dev]
    namespace = namespace_from_args(argv)
    expect(namespace).to be "dev"
  end
end
