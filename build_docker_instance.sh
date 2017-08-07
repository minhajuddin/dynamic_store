#!/bin/bash

set -e

app_version="$(mix run -e 'IO.puts "APP_VERSION:#{Mix.Project.config[:version]}"' | grep APP_VERSION: | sed -e 's/APP_VERSION://')"
echo "> building docker image ds:$app_version"
docker build . -t "ds:$app_version"
echo "> finished building docker image"
