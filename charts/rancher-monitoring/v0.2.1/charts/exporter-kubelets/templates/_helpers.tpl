{{- define "kubelet.serviceMonitor.resourcePath" -}}
{{- $kubeTargetVersion := default .Capabilities.KubeVersion.GitVersion .Values.kubeTargetVersionOverride }}
{{- if semverCompare ">=1.20.0-0" $kubeTargetVersion -}}
/metrics/resource
{{- else -}}
/metrics/resource/v1alpha1
{{- end -}}
{{- end }}