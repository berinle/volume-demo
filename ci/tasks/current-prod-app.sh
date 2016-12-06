#!/bin/bash

set -xe

pwd
env

cf api $CF_API --skip-ssl-validation

cf login -u $CF_USER -p $CF_PWD -o "$CF_ORG" -s "$CF_SPACE"

cf apps

set +e
export CURR_APP_COLOR=$(cf apps | grep "$CF_APP.$CF_APP_DOMAIN" | awk '{print $1}')
if [[ $CURR_APP_COLOR =~ .*green.* ]]
then
  echo "green" > ./current-app-info/current-prod-app.txt
  echo "blue" > ./current-app-info/next-app.txt
else
  echo "blue" > ./current-app-info/current-app.txt
  echo "green" > ./current-app-info/next-app.txt
fi
set -xe

echo "Current main app routes to app instance $(cat ./current-app-info/current-app.txt)"
echo "New version of app to be deployed to instance $(cat ./current-app-info/next-app.txt)"
