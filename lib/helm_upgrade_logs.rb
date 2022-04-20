# frozen_string_literal: true

require 'open3'
require_relative "helm_upgrade_logs/version"

ENV['helm_upgrade_logs_log_start'] ||= '90'
ENV['helm_upgrade_logs_pod_start'] ||= '35'

# Approach not ideal as it will for all containers to be ready and want to stream logs before that
def wait_for_container_ready
  wait_pid = Process.spawn 'kubectl wait --for=condition=ContainersReady pod --selector "app.kubernetes.io/managed-by=Helm" --timeout=30s'
  Process.wait wait_pid
end

# Wait for pods with logs to be present
# Not ideal due to https://github.com/kubernetes/kubernetes/issues/28746
def wait_for_pod_to_log
  ENV['helm_upgrade_logs_log_start'].to_i.times do |i|
    sleep 1
    stdout, stderr, _ = Open3.capture3 "kubectl logs -lapp.kubernetes.io/instance=#{$release_name}"
    if stderr.empty? && !stdout.strip.empty?
      puts '[INFO] Pods with logs found'
      break
    else
      puts "[INFO] Waiting for pod logs: #{stderr}" if i % 3 == 0
    end
  end
end

def wait_for_specific_pod_to_log(pod_name)
  ENV['helm_upgrade_logs_pod_start'].to_i.times do |i|
    sleep 1
    stdout, stderr, _ = Open3.capture3 "kubectl logs #{pod_name}"
    if stderr.empty? && !stdout.strip.empty?
      puts "[INFO] Pod #{pod_name} with logs found"
      break
    else
      puts "[INFO] Waiting for pod #{pod_name} logs: #{stderr}" if i % 2 == 0
    end
  end
end

def get_pods
  stdout, stderr, _ = Open3.capture3 "kubectl get pods -lapp.kubernetes.io/instance=#{$release_name} -o name"
  if stderr.empty?
    stdout.lines.collect { |pod| pod.strip }
  else
    []
  end
end

module HelmUpgradeLogs
  class Error < StandardError; end
  # Your code goes here...
end
