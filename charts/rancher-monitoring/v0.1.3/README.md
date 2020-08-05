# rancher-monitoring

Installs [prometheus-operator](https://github.com/coreos/prometheus-operator) to create/configure/manage Prometheus clusters atop Kubernetes.

> **Tip**: Only use for Rancher Monitoring!!!

## Changelog

* 0.1.3
    * Added chart webhook-receiver to support recipients that are not directly supported by Prometheus
    * Added functionality to automatically load custom grafana dashboards from correclty labeled configmaps

## Prerequisites
  - >= Rancher 2.3.3
