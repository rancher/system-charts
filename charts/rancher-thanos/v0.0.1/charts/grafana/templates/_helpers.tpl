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

{{- define "system_default_registry" -}}
{{- if .Values.global.systemDefaultRegistry -}}
{{- printf "%s/" .Values.global.systemDefaultRegistry -}}
{{- else -}}
{{- "" -}}
{{- end -}}
{{- end -}}
