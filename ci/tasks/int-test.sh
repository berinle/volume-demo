#!/bin/bash

set -e

export NEXT_APP_COLOR=$(cat ./current-app-info/next-app.txt)
export NEXT_APP_URL=http://$CF_APP-$NEXT_APP_COLOR.$CF_APP_DOMAIN/

echo "Running curl integration tests..."

curl -k $NEXT_APP_URL