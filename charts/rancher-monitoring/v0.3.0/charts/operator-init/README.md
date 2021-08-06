# operator-init

## Introduction

This chart bootstraps prometheus-operator's [CRDs](https://github.com/helm/charts/tree/master/stable/prometheus-operator/templates/prometheus-operator)
which are an internal implementation detail of prometheus-operator. CRDs define data structures for storing runtime configuration
specified by a human operator.

This chart must be run to completion prior to running other Prometheus Operator charts, or other prometheus-operator charts will fail to initialize.

## Prerequisites

- Kubernetes 1.9 or newer cluster with RBAC (Role-Based Access Control) enabled is required
- Helm 2.7.2 or newer or alternately the ability to modify RBAC rules is also required

## Resources Required

The chart deploys pods that consume minimal resources.

## Uninstalling the Chart

> Warning: Deleting CRDs will delete any configuration that you have made to prometheus-operator.

To delete all CRDs, run the following command
    ```
    kubectl delete -f files/.
    ```
