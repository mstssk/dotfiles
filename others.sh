#!/bin/bash -eu

cd `dirname $0`

DEV_DIR=~/Development

mkdir -p $DEV_DIR

# Google Cloud SDK
wget -O $DEV_DIR/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-196.0.0-darwin-x86_64.tar.gz
tar xvzf $DEV_DIR/google-cloud-sdk.tar.gz -C $DEV_DIR
$DEV_DIR/google-cloud-sdk/install.sh --quiet
gcloud components update --quiet
gcloud components install app-engine-go --quiet
chmod +x $DEV_DIR/google-cloud-sdk/platform/google_appengine/goapp
# gcloud components install beta -q
