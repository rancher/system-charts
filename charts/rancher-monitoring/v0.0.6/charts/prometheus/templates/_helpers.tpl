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


{{- define "serviceMonitor.namespace.selector" -}}
serviceMonitorNamespaceSelector:
{{- if and .Values.serviceMonitorNamespaceSelector .Values.serviceMonitorNamespaceSelector.matchLabels }}
  matchLabels:
{{ toYaml .Values.serviceMonitorNamespaceSelector.matchLabels | indent 4}}
{{- end }}
  matchExpressions:
{{- if ne .Values.level "cluster" }}
  # since > v0.0.5, the Prometheus of project-level monitoring would be forbidden to scrape its project's ServiceMonitors
  - key: "field.cattle.io/projectId"
    operator: "In"
    values:
    - "p-fake-project-id"
{{- end }}
{{- if and .Values.serviceMonitorNamespaceSelector .Values.serviceMonitorNamespaceSelector.matchExpressions }}
{{ toYaml .Values.serviceMonitorNamespaceSelector.matchExpressions | indent 2}}
{{- end }}
{{- end -}}


{{- define "rule.namespace.selector" -}}
ruleNamespaceSelector:
{{- if and .Values.ruleNamespaceSelector .Values.ruleNamespaceSelector.matchLabels }}
  matchLabels:
{{ toYaml .Values.ruleNamespaceSelector.matchLabels | indent 4}}
{{- end }}
  matchExpressions:
{{- if .Values.global.projectName }}
  - key: "field.cattle.io/projectId"
    operator: "In"
    values:
    - "{{ .Values.global.projectName }}"
{{- end }}
{{- if and .Values.ruleNamespaceSelector .Values.ruleNamespaceSelector.matchExpressions }}
{{ toYaml .Values.ruleNamespaceSelector.matchExpressions | indent 2}}
{{- end }}
{{- end -}}


{{- define "rule.selector" -}}
ruleSelector:
{{- if and .Values.ruleSelector .Values.ruleSelector.matchLabels }}
  matchLabels:
{{ toYaml .Values.ruleSelector.matchLabels | indent 4}}
{{- end }}
  matchExpressions:
{{- if ne .Values.level "cluster" }}
  - key: "source"
    operator: "In"
    values: [ "rancher-alert" ]
{{- end }}
{{- if and .Values.ruleSelector .Values.ruleSelector.matchExpressions }}
{{ toYaml .Values.ruleSelector.matchExpressions | indent 2}}
{{- end }}
{{- end }}