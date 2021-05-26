{{/* vim: set filetype=mustache: */}}

{{- define "additional-scrape-configs.yaml" -}}
{{- $root := . -}}
{{- $yamls := dict -}}
{{- if eq .Values.level "cluster" -}}
  {{- range $path, $bytes := .Files.Glob "additionals/c-scrape_*.yaml" -}}
    {{- $tpl := tpl ($bytes | toString) $root }}
    {{- if $tpl }}
    {{- $_ := set $yamls $tpl "" -}}
    {{- end }}
  {{- end -}}
{{- end -}}
{{- range $path, $bytes := .Files.Glob "additionals/w-scrape_*.yaml" -}}
  {{- $tpl := tpl ($bytes | toString) $root }}
  {{- if $tpl }}
  {{- $_ := set $yamls $tpl "" -}}
  {{- end }}
{{- end -}}
{{- if .Values.additionalScrapeConfigs -}}
  {{- $_ := set $yamls (.Values.additionalScrapeConfigs | toYaml) "" -}}
{{- end -}}
{{- if $yamls -}}
  {{- keys $yamls | join "\n" | quote -}}
{{- end -}}
{{- end -}}


{{- define "additional-alertmanager-configs.yaml" -}}
{{- $root := . -}}
{{- $yamls := dict -}}
{{- if eq .Values.level "cluster" -}}
  {{- range $path, $bytes := .Files.Glob "additionals/c-altermanager_*.yaml" -}}
    {{- $tpl := tpl ($bytes | toString) $root }}
    {{- if $tpl }}
    {{- $_ := set $yamls $tpl "" -}}
    {{- end }}
  {{- end -}}
{{- end -}}
{{- range $path, $bytes := .Files.Glob "additionals/w-altermanager_*.yaml" -}}
  {{- $tpl := tpl ($bytes | toString) $root }}
  {{- if $tpl }}
  {{- $_ := set $yamls $tpl "" -}}
  {{- end }}
{{- end -}}
{{- if .Values.additionalAlertManagerConfigs -}}
  {{- $_ := set $yamls (.Values.additionalAlertManagerConfigs | toYaml) "" -}}
{{- end -}}
{{- if $yamls -}}
  {{- keys $yamls | join "\n" | quote -}}
{{- end -}}
{{- end -}}


{{- define "app.auth.fullname" -}}
{{- $name := include "app.name" . -}}
{{- printf "%s-auth-%s" $name .Release.Name -}}
{{- end -}}

{{- define "namespace.selector" -}}
{{- if and .selector .selector.matchLabels -}}
matchLabels:
{{ toYaml .selector.matchLabels | indent 2 }}
{{- end }}
matchExpressions:
{{- if .projectName }}
- key: "field.cattle.io/projectId"
  operator: "In"
  values: [ "{{ .projectName }}" ]
{{- end }}
{{- if and .selector .selector.matchExpressions }}
{{ toYaml .selector.matchExpressions }}
{{- end -}}
{{- end -}}

{{- define "serviceMonitor.namespace.selector" -}}
{{- $rootContext := dict -}}
{{- $_ := set $rootContext "projectName" .Values.global.projectName -}}
{{- $_ := set $rootContext "selector" .Values.serviceMonitorNamespaceSelector -}}
serviceMonitorNamespaceSelector:
{{ include "namespace.selector" $rootContext | indent 2 }}
{{- end -}}

{{- define "rule.namespace.selector" -}}
{{- $rootContext := dict -}}
{{- $_ := set $rootContext "projectName" .Values.global.projectName -}}
{{- $_ := set $rootContext "selector" .Values.ruleNamespaceSelector -}}
ruleNamespaceSelector:
{{ include "namespace.selector" $rootContext | indent 2 }}
{{- end -}}

{{- define "rule.selector" -}}
ruleSelector:
{{- if and .Values.ruleSelector .Values.ruleSelector.matchLabels }}
  matchLabels:
{{ toYaml .Values.ruleSelector.matchLabels | indent 4}}
{{- end }}
  matchExpressions:
{{- if eq .Values.level "project" }}
  - key: "source"
    operator: "In"
    values: [ "rancher-alert" ]
{{- end }}
{{- if and .Values.ruleSelector .Values.ruleSelector.matchExpressions }}
{{ toYaml .Values.ruleSelector.matchExpressions | indent 2}}
{{- end }}
{{- end }}