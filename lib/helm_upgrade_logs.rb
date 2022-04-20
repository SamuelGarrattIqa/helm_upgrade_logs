# frozen_string_literal: true

require 'open3'
require_relative "helm_upgrade_logs/version"

# Approach not ideal as it will for all containers to be ready and want to stream logs before that
def wait_for_container_ready
  wait_pid = Process.spawn 'kubectl wait --for=condition=ContainersReady pod --selector "app.kubernetes.io/managed-by=Helm" --timeout=30s'
  Process.wait wait_pid
end

# Wait for pods with logs to be present
# Not ideal due to https://github.com/kubernetes/kubernetes/issues/28746
def wait_for_pod_to_log
  90.times {
    sleep 1
    stdout, stderr, _ = Open3.capture3 "kubectl logs -lapp.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=#{$release_name}"
    if stderr.empty? && !stdout.strip.empty?
      puts 'Pods with logs found'
      break
    else
      puts "Waiting for pod logs: #{stderr}"
    end
  }
end

def wait_for_specific_pod_to_log(pod_name)
  30.times {
    sleep 1
    stdout, stderr, _ = Open3.capture3 "kubectl logs #{pod_name}"
    if stderr.empty? && !stdout.strip.empty?
      puts "Pod #{pod_name} with logs found"
      break
    else
      puts "Waiting for pod #{pod_name} logs: #{stderr}"
    end
  }
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
