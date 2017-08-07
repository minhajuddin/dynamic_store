#!/bin/bash

# this script runs from inside a docker container
set -e

cd /opt/build
mix release
