#!/bin/bash

set -e

ELIXIR_VERSION="1.5.1"
DOCKER_IMAGE="bitwalker/alpine-elixir:$ELIXIR_VERSION"

app_version="$(mix run -e 'IO.puts Mix.Project.config[:version]')"

docker run --rm -it --user=root \
  --env "MIX_ENV=prod" \
  --volume "$(pwd):/opt/build" \
  --workdir "/opt/build" \
  $DOCKER_IMAGE \
  mix release

