# Rancher Logging

* Installs [Fluentd](https://www.fluentd.org/) and flexvolume log driver to collect container logs in Rancher

## Changelog

* 0.1.5
    * Added option `global.privileged` to enable the privileged securityContext in logging containers. This is needed when running SELinux enabled Docker on the host(s).
