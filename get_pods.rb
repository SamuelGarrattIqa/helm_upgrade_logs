require 'open3'

$release_name = 'redis'
stdout, stderr, _ = Open3.capture3 "kubectl get pods -lapp.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=#{$release_name} -o name"
if stderr.empty?
  puts stdout.lines.join(',')
end
