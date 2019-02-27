#!/usr/bin/env sh

set -e

{
  while true; do
    inotifywait -m ~/.factom/private -e create -e modify -r |
      while read path action file; do
        echo "inotifywait: ${action} event on ${path}${file}"
        envsubst < ~/.factom/private/factomd.conf > ~/.factom/private-conv/factomd.conf
      done
  done
} &

envsubst < ~/.factom/private/factomd.conf > ~/.factom/private-conv/factomd.conf

exec /go/bin/factomd "$@"
