#!/bin/bash

set -e

docker run --rm --volume "$(pwd)/db:/opt/app/db" ds:0.1.0
