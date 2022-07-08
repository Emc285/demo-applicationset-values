{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cgd-corporateloans-cde-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "cgd-corporateloans-cde-engine-service.name" -}}
{{- default (printf "%s" "cgd-corporateloans-cde-engine-service") .Values.engine.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Wiremock
Expand the name of the chart.
*/}}
{{- define "cgd-corporateloans-cde-service-wiremock.name" -}}
{{- default (printf "%s-%s" .Chart.Name "wiremock") .Values.wiremock.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cgd-corporateloans-cde-service.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Engine
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cgd-corporateloans-cde-engine-service.fullname" -}}
{{- if .Values.engine.fullnameOverride -}}
{{- .Values.engine.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- (printf "%s" "cgd-corporateloans-cde-engine-service") | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/* Wiremock
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cgd-corporateloans-cde-service-wiremock.fullname" -}}
{{- if .Values.wiremock.fullnameOverride -}}
{{- .Values.wiremock.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default (printf "%s-%s" .Chart.Name "wiremock") .Values.wiremock.nameOverride -}}
{{- if contains .Release.Name $name -}}
{{- $name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cgd-corporateloans-cde-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cgd-corporateloans-cde-engine-service.chart" -}}
{{- printf "%s-%s"  "cgd-corporateloans-cde-engine-service" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Wiremock
Create chart name and version as used by the chart label.
*/}}
{{- define "cgd-corporateloans-cde-service-wiremock.chart" -}}
{{- printf "%s-%s-%s" .Chart.Name "wiremock" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "cgd-corporateloans-cde-service.labels" -}}
helm.sh/chart: {{ include "cgd-corporateloans-cde-service.chart" . }}
{{ include "cgd-corporateloans-cde-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Engine labels
*/}}
{{- define "cgd-corporateloans-cde-engine-service.labels" -}}
helm.sh/chart: {{ include "cgd-corporateloans-cde-engine-service.chart" . }}
{{ include "cgd-corporateloans-cde-engine-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* Wiremock
Common labels
*/}}
{{- define "cgd-corporateloans-cde-service-wiremock.labels" -}}
helm.sh/chart: {{ include "cgd-corporateloans-cde-service-wiremock.chart" . }}
{{ include "cgd-corporateloans-cde-service-wiremock.selectorLabels" . }}
{{- if .Values.release.appVersion }}
app.kubernetes.io/version: {{ .Values.release.appVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "cgd-corporateloans-cde-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cgd-corporateloans-cde-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Engine Selector labels
*/}}
{{- define "cgd-corporateloans-cde-engine-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cgd-corporateloans-cde-engine-service.name" . }}
app.kubernetes.io/instance: cgd-corporateloans-cde-engine-service
{{- end -}}

{{/* Wiremock
Selector labels
*/}}
{{- define "cgd-corporateloans-cde-service-wiremock.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cgd-corporateloans-cde-service-wiremock.name" . }}
app.kubernetes.io/instance: {{ printf "%s-%s" .Release.Name "wiremock" }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "cgd-corporateloans-cde-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "cgd-corporateloans-cde-service.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "common.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Create secret or use local credentials
*/}}
{{- define "cgd-corporateloans.common.existingSecret.render" -}}
- name: {{ .resource }}
{{- if .context.existingSecret }}
  valueFrom:
    secretKeyRef:
      name: {{ .context.existingSecret }}
      key: {{ .key }}
{{- else }}
  value: {{ index .context .key }}
{{- end -}}
{{- end -}}