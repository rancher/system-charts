{{/* vim: set filetype=mustache: */}}

{{- define "app.controlplane.name" -}}
{{- $name := include "app.name" . -}}
{{- printf "%s-controlplane" $name -}}
{{- end -}}


{{- define "app.controlplane.fullname" -}}
{{- $name := include "app.controlplane.name" . -}}
{{- printf "%s-%s" $name .Release.Name -}}
{{- end -}}


{{- define "app.etcd.name" -}}
{{- $name := include "app.name" . -}}
{{- printf "%s-etcd" $name -}}
{{- end -}}


{{- define "app.etcd.fullname" -}}
{{- $name := include "app.etcd.name" . -}}
{{- printf "%s-%s" $name .Release.Name -}}
{{- end -}}