#!/usr/bin/env bash

set -e

display_help() {
  echo "${1}"
  echo "${0} <create|delete> --release <release>"
  exit ${2}
}

while [[ "$#" > 0 ]]; do case $1 in
  create) command="create";;
  delete) command="delete";;
  -r|--release) release="${2}"; shift;;
  -h|--help) display_help "Command syntax: " 0;;
  *) display_help "Unknown parameter passed: ${1}" 1;;
esac; shift; done

if [[ -z "${release}" ]]; then
  display_help "The '--release' parameter is required" 1
fi

if [[ -z "${command}" ]]; then
  display_help "The command must be 'create' or 'delete'" 1
fi

name="${release}-factomd-secret"
if [[ "${release}" =~ "factomd" ]]; then
  name="${release}-secret"
fi

if [[ "${command}" = "create" ]]; then
  privateKey=""
  while [[ -z "${privateKey}" ]]; do
    read -s -p "Enter the server private key: " privateKey
  done

  echo ""

  kubectl create secret generic \
    ${name} \
    --from-literal="localServerPrivateKey=${privateKey}"
else
  kubectl delete secret ${name}
fi

