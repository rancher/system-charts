{{/* vim: set filetype=mustache: */}}

{{- define "app.dashboards.fullname" -}}
{{- $name := include "app.name" . -}}
{{- printf "%s-%s-dashboards" $name .Release.Name -}}
{{- end -}}


{{- define "app.provisionings.fullname" -}}
{{- $name := include "app.name" . -}}
{{- printf "%s-%s-provisionings" $name .Release.Name -}}
{{- end -}}

{{- define "app.dashboards.istio-fullname" -}}
{{- $name := include "app.name" . -}}
{{- printf "%s-%s-%s-dashboards" $name "istio" .Release.Name -}}
{{- end -}}
