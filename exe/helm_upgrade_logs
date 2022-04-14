#!/bin/bash

set -euo pipefail

if [[ -n "${DOTFILES_DEBUG:-}" ]]; then
  set -x
fi

function ensure_path_entry() {
  local entries=("$@")

  for entry in "${entries[@]}"; do
    if [[ ":${PATH}:" != *":${entry}:"* ]]; then
      export PATH="${entry}:${PATH}"
    fi
  done
}

function log_color() {
  local color_code="$1"
  shift

  printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}

function log_red() {
  log_color "0;31" "$@"
}

function log_blue() {
  log_color "0;34" "$@"
}

function log_green() {
  log_color "1;32" "$@"
}

function log_yellow() {
  log_color "1;33" "$@"
}

function log_task() {
  log_blue "🔃" "$@"
}

function log_manual_action() {
  log_red "⚠️" "$@"
}

function log_c() {
  log_yellow "👉" "$@"
}

function c() {
  log_c "$@"
  "$@"
}

function c_exec() {
  log_c "$@"
  exec "$@"
}

function log_error() {
  log_red "❌" "$@"
}

function log_info() {
  log_red "ℹ️" "$@"
}

function error() {
  log_error "$@"
  exit 1
}

function sudo() {
  if ! command sudo --non-interactive true 2>/dev/null; then
    log_manual_action "Root privileges are required, please enter your password below"
    command sudo --validate
  fi
  command sudo "$@"
}

function is_apt_package_installed() {
  local package="$1"

  dpkg -l "${package}" &>/dev/null
}

function not_during_test() {
  if [[ "${DOTFILES_TEST:-}" == "true" ]]; then
    log_info "Skipping '${*}' because we are in test mode"
  else
    "${@}"
  fi
}

# https://stackoverflow.com/a/53640320/12156188
function service_exists() {
    local n=$1
    if [[ $(systemctl list-units --all -t service --full --no-legend "$n.service" | sed 's/^\s*//g' | cut -f1 -d' ') == $n.service ]]; then
        return 0
    else
        return 1
    fi
}

################################################################
## ABOVE is script_libray
## BELOW is helm install debug
################################################################

mkdir helm_upgrade_log_tmp
watching_pods_logs_file=$(mktemp helm_upgrade_log_tmp/helm-upgrade-logs.watching-pods-logs.XXXXXX)
watching_pods_events_file=$(mktemp helm_upgrade_log_tmp/helm-upgrade-logs.watching-pods-events.XXXXXX)

function cleanup() {
  rm -f "${watching_pods_logs_file}" "${watching_pods_events_file}" || true
  jobs -pr | xargs -r kill
}

trap cleanup EXIT

function prefix_output() {
  local prefix="$1"
  local color_code="$2"
  shift 2

  local sed_replace
  sed_replace=$(printf "\033[${color_code}m%s: &\033[0m" "${prefix}")

  # shellcheck disable=SC2312
  "$@" &> >(sed "s,^.*$,${sed_replace}," >&2)
}

function watch_pods() {
  local release="$1"

  sleep 3 # Prevent flodding the logs with the initial output
  prefix_output "pods" "1;32" c kubectl get pods \
    --watch \
    --selector "app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=${release}"
}

function watch_pod_logs() {
  local pod="$1"

  if grep -q "^${pod}$" "${watching_pods_logs_file}"; then
    return
  fi

  echo "${pod}" >>"${watching_pods_logs_file}"

  prefix_output "pod ${pod} logs" "0;34" c kubectl logs \
    --all-containers \
    --prefix \
    --follow \
    "${pod}" || true

  # remove from watch list (it may be added again)
  sed -i "/^${pod}$/d" "${watching_pods_logs_file}"
}

function watch_pod_events() {
  local pod="$1"

  if grep -q "^${pod}$" "${watching_pods_events_file}"; then
    return
  fi

  echo "${pod}" >>"${watching_pods_events_file}"

  prefix_output "pod ${pod} events" "0;35" c kubectl get events \
    --watch-only \
    --field-selector involvedObject.name="${pod}" || true

  # remove from watch list (it may be added again)
  sed -i "/^${pod}$/d" "${watching_pods_events_file}"
}

function watch_pods_logs_and_events() {
  local release="$1"

  sleep 5 # Prevent flodding the logs with the initial output
  while true; do
    local args=(
      --selector "app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=${release}"
      --output jsonpath='{.items[*].metadata.name}'
    )

    for pod in $(
      kubectl get pods "${args[@]}"
    ); do
      watch_pod_events "${pod}" &
    done

    for pod in $(
      kubectl get pods \
        --field-selector=status.phase=Running \
        "${args[@]}"
    ); do
      watch_pod_logs "${pod}" &
    done

    sleep 1
  done
}

function get_first_non_option() {
  for arg in "$@"; do
    if [[ "${arg}" != "-"* ]]; then
      echo "${arg}"
      return
    fi
  done
}

release="$(get_first_non_option "$@")"

c helm upgrade "$@" --wait &
pid="$!"

watch_pods "${release}" &

watch_pods_logs_and_events "${release}" &

wait "${pid}"
rm -rf helm_upgrade_log_tmp
