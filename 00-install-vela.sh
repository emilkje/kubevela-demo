#!/usr/bin/bash

helm repo add kubevela https://charts.kubevela.net/core
helm repo update
echo 'installing kubevela helm chart...'
helm install --create-namespace -n vela-system kubevela kubevela/vela-core --version 1.2.4 --wait