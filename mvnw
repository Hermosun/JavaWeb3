#!/bin/bash

# Script to run Maven in a Docker container if local Maven is not available

# Try to run Maven locally first
if command -v mvn &> /dev/null; then
    echo "Using local Maven installation"
    mvn "$@"
else
    echo "Local Maven not found, using Docker container"
    # Run Maven in a Docker container
    docker run --rm \
      -v "$(pwd)":/app \
      -w /app \
      maven:3.8-openjdk-11 \
      mvn "$@"
fi