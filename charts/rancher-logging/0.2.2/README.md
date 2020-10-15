# Rancher Logging

* Installs [Fluentd](https://www.fluentd.org/) and flexvolume log driver to collect container logs in Rancher

## Introduction

This chart bootstraps a [Fluentd](https://www.fluentd.org/) daemonset and a [Log-Aggregator](https://github.com/rancher/log-aggregator) flexvolume on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.
It's use for sends logs to log target config in rancher.

## Prerequisites
  - Rancher 2.1+