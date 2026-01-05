#!/usr/bin/env bash

set -e -u

# Usage.
usage() {
  echo "Usage: ./local/install.sh [OPTIONS]" >&2
  echo "-h                    : Display usage" >&2
  echo "-s                    : Stop the site containers" >&2
  echo "-x                    : Shutdown and remove the site containers" >&2
  echo "-v                    : Also remove the volumes when shutting down the containers" >&2
  exit 1
}

stop="no"
shutdown="no"
shutdown_options=""

# Parse options.
while getopts "hsxv" opt; do
  case $opt in
    h)
      usage
      ;;
    s)
      stop="yes"
      ;;
    x)
      shutdown="yes"
      ;;
    v)
      shutdown_options="$shutdown_options -v"
      ;;
    *)
      usage
      ;;
  esac
done

function docker_compose {
  docker compose -f local/docker-compose.yml "$@"
}

# Load the environment variables.
# They are only available in this script as we don't export them.
source local/.env

# Stop the containers.
if [ "$stop" = "yes" ]; then
  echo "Stop the containers."
  docker_compose stop || true
  exit 0
fi

# Stop and remove the containers.
if [ "$shutdown" = "yes" ]; then
  echo "Stop and remove the containers."
  docker_compose down $shutdown_options || true
  exit 0
fi

# Create the site container.
echo "Create the site container."
docker_compose up -d --remove-orphans

# Dump some information about the created containers.
echo "Dump some information about the created containers."
docker_compose ps -a
