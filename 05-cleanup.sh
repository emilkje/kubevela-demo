#!/usr/bin/bash

kubectl delete TraitDefinition autoscaler
kubectl delete TraitDefinition route

kubectl delete ComponentDefinition backend
kubectl delete ComponentDefinition frontend

helm uninstall kubevela -n vela-system
kubectl delete ns vela-system