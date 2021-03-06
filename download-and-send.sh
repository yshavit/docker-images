#!/bin/bash

function check_env_var_set() {
  local redact=no
  if [[ "$1" == PASSWORD ]]; then
    redact=yes
    shift
  fi
  local var_to_set="$1"

  if [[ -z "${!var_to_set}" ]]; then
    echo "${var_to_set} is not set." 1>&2
    shift
    if [[ -n "$@" ]]; then
      echo "${@}" 1>&2
    fi
    exit 1
  elif [[ "$redact" == yes ]]; then
    echo "Running with ${var_to_set}=<redacted>"
  else
    echo "Running with ${var_to_set}=${!var_to_set}"
  fi
}

check_env_var_set RECIPE 'It should be the name of a recipe, without the ".recipe" suffix.'
check_env_var_set EMAIL_FROM_USERNAME
check_env_var_set PASSWORD EMAIL_FROM_PASSWORD
check_env_var_set EMAIL_FROM_RELAY
check_env_var_set EMAIL_FROM_PORT
check_env_var_set EMAIL_FROM
check_env_var_set EMAIL_TO

if [[ -n "${VERBOSE}" ]]; then
  VERBOSE=-v
fi

set -e

now_pretty="$(date)"
out_file="/tmp/$(date -u +'%Y%m%dT%H%M%SZ').mobi"

ebook-convert "${RECIPE}.recipe" "${out_file}"
calibre-smtp -s "Calibre: ${RECIPE}" ${VERBOSE} \
  -a "${out_file}" \
  -u "${EMAIL_FROM_USERNAME}" -p "${EMAIL_FROM_PASSWORD}" -r "${EMAIL_FROM_RELAY}" --port "${EMAIL_FROM_PORT}" \
  "${EMAIL_FROM}" "${EMAIL_TO}" \
  "Downloaded \"${RECIPE}\" on ${now_pretty}"

echo "Sent attachment to ${EMAIL_TO}."
echo "Done."
