{{- define "kubelet.serviceMonitor.resourcePath" -}}
{{- $kubeTargetVersion := default .Capabilities.KubeVersion.GitVersion .Values.kubeTargetVersionOverride }}
{{- if semverCompare ">=1.20.0-0" $kubeTargetVersion -}}
{{ default .Values.kubelet.serviceMonitor.resourcePath "/metrics/resource" }}
{{- else -}}
{{ default .Values.kubelet.serviceMonitor.resourcePath "/metrics/resource/v1alpha1" }}
{{- end -}}
{{- end }}
