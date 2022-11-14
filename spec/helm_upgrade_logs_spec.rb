# frozen_string_literal: true

RSpec.describe HelmUpgradeLogs do
  it "has a version number" do
    expect(HelmUpgradeLogs::VERSION).not_to be nil
  end

  context "namespace from args" do
    it "short form" do
      argv = %w[--install nginx bitnami/nginx -n dev]
      namespace = namespace_from_args(argv)
      expect(namespace).to be "dev"
    end

    it "long form" do
      argv = %w[--install --namespace qa nginx bitnami/nginx]
      namespace = namespace_from_args(argv)
      expect(namespace).to be "qa"
    end
  end

  context "release_name" do
    it "can be extracted as first param after install" do
      rel_name = release_name_from_args(%w[--install nginx bitnami/nginx -n dev])
      expect(rel_name).to eq 'nginx'
    end
    it "can be extracted after set param arguments" do
      rel_name = release_name_from_args(%w[--install --set tag=value nginx2 bitnami/nginx -n dev])
      expect(rel_name).to eq 'nginx2'
    end
  end

  it "does not affect params" do
    args = %w[--install --set tag=value --set tag2=val2 -n dev --render-subchart-notes nginx2 bitnami/nginx
              --values test1.yaml,test2.yaml --verify --reuse-values]
    args_clone = args.clone
    rel_name = release_name_from_args args
    namespace = namespace_from_args args
    expect(rel_name).to eq "nginx2"
    expect(namespace).to eq "dev"
    expect(args_clone).to eq args
  end
end
