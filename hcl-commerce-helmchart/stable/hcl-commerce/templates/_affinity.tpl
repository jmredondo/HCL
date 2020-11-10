######################################################
# Licensed Materials - Property of HCL Technologies
#  HCL Commerce
#  (C) Copyright HCL Technologies Limited 1996, 2020
######################################################
{{/* affinity - https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ */}}

{{- define "nodeaffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
    {{- include "nodeAffinityRequiredDuringScheduling" . }}
    preferredDuringSchedulingIgnoredDuringExecution:
    {{- include "nodeAffinityPreferredDuringScheduling" . }}
{{- end }}

{{- define "nodeAffinityRequiredDuringScheduling" }}
    #If you specify multiple nodeSelectorTerms associated with nodeAffinity types,
    #then the pod can be scheduled onto a node if one of the nodeSelectorTerms is satisfied.
    #
    #If you specify multiple matchExpressions associated with nodeSelectorTerms,
    #then the pod can be scheduled onto a node only if all matchExpressions can be satisfied.
    #
    #valid operators: In, NotIn, Exists, DoesNotExist, Gt, Lt
      nodeSelectorTerms:
      - matchExpressions:
        - key: beta.kubernetes.io/arch
          operator: In
          values:
        {{- range $key, $val := .Values.arch }}
          {{- if gt ($val | trunc 1 | int) 0 }}
          - {{ $key }}
          {{- end }}
        {{- end }}
{{- end }}

{{- define "nodeAffinityPreferredDuringScheduling" }}
  {{- range $key, $val := .Values.arch }}
    {{- if gt ($val | trunc 1 | int) 0 }}
    - weight: {{ $val | trunc 1 | int }}
      preference:
        matchExpressions:
        - key: beta.kubernetes.io/arch
          operator: In
          values:
          - {{ $key }}
    {{- end }}
  {{- end }}
{{- end }}

{{- define "xcapp-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.xcApp.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}

{{- define "tsapp-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.tsApp.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}

{{- define "searchapp-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.searchAppSlave.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}

{{- define "crsapp-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.crsApp.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}


{{- define "tsweb-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.tsWeb.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}

{{- define "toolingweb-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.toolingWeb.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}

{{- define "storeweb-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.storeWeb.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}

{{- define "nifiapp-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.nifiApp.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}

{{- define "registryapp-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.registryApp.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}

{{- define "ingestapp-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.ingestApp.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}

{{- define "queryapp-podAntiAffinity" }}
#https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
  podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm: 
          labelSelector:
            matchExpressions:
            - key: component
              operator: In
              values:
              - {{ .Values.common.tenant }}{{ .Values.common.environmentName}}{{ .Values.common.environmentType }}{{.Values.queryApp.name}}
          topologyKey: kubernetes.io/hostname
{{- end }}
