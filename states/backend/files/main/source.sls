{%- set basePath = "{}/{}".format(pillar.basePath, pillar.projectName) -%}
{%- set groupId = pillar.groupId | join('.') -%}
{%- set groupPath = pillar.groupId | join('/') | replace('-','') -%}
{%- set packageId = pillar.groupId | join('.') | replace('-','') -%}
{%- set projectName = pillar.projectName -%}
{%- set ktorFeatures = pillar.modules.backend.ktor.server.features -%}
{%- set sourceMainDir = "{}/backend/src/main/kotlin/{}/{}".format(basePath, groupPath, pillar.projectName) -%}
{%- set sourcePath = "salt://backend/files/main/source" -%}

{% from 'lib.sls' import subDir, createOnlyFile with context %}

base-directory:
  file.directory:
    - name: {{ sourceMainDir }}
    - mode: 755
    - makedirs: True
    - require:
      - file: {{ basePath }}/backend

{{ subDir('gateway') }}
{{ subDir('routes') }}
{{ subDir('service') }}
{{ subDir('util') }}

{% for gateway in pillar.modules.backend.gateways %}
gatewaydir-{{ gateway }}:
  file.directory:
    - name: {{ sourceMainDir }}/gateway/{{ gateway }}
    - mode: 755
    - require:
      - file: {{ sourceMainDir }}/gateway
{% endfor %}

application-kt:
  file.managed:
    - name: {{ sourceMainDir }}/Application.kt
    - source: {{ sourcePath }}/Application.kt.jinja
    - template: jinja
    - context:
      packageId: {{ packageId }}
      projectName: {{ projectName }}

appconfig-kt:
  file.managed:
    - name: {{ sourceMainDir }}/AppConfig.kt
    - source: {{ sourcePath }}/AppConfig.kt.jinja
    - template: jinja
    - context:
      packageId: {{ packageId }}
      projectName: {{ projectName }}

index-route:
  {{ createOnlyFile('routes','IndexRoute.kt') }}

health-check-route:
  {{ createOnlyFile('routes','HealthCheckRoute.kt') }}

route-util:
  {{ createOnlyFile('routes','util.kt') }}

{% if pillar.modules.backend.ktor.client.use %}
http-client:
  {{ createOnlyFile('gateway', 'HttpClient.kt') }}
{% endif %}

{% if 'jira' in pillar.modules.backend.gateways %}
jira-api:
  {{ createOnlyFile('gateway/jira', 'JiraApi.kt') }}

jira-config:
  {{ createOnlyFile('gateway/jira', 'JiraConfig.kt') }}
{% endif %}

{% if 'insight' in pillar.modules.backend.gateways %}
insight-api:
  {{ createOnlyFile('gateway/insight', 'InsightApi.kt') }}

insight-config:
  {{ createOnlyFile('gateway/insight', 'InsightConfig.kt') }}
{% endif %}

{% if 'confluence' in pillar.modules.backend.gateways %}
confluence-api:
  {{ createOnlyFile('gateway/confluence', 'ConfluenceApi.kt') }}

confluence-config:
  {{ createOnlyFile('gateway/confluence', 'ConfluenceConfig.kt') }}

scroll-translations-api:
  {{ createOnlyFile('gateway/confluence', 'ScrollTranslationsApi.kt') }}
{% endif %}

{% if ktorFeatures.saml.selected %}
ktor-saml-route:
  {{ createOnlyFile('routes','SamlRoute.kt') }}
{% endif %}

{% if ktorFeatures.sessions.selected %}
ktor-session-config:
  {{ createOnlyFile('util','SessionConfig.kt') }}

ktor-session-service:
  {{ createOnlyFile('service','SessionService.kt') }}

ktor-session-route:
  {{ createOnlyFile('routes','SessionRoute.kt') }}
{% endif %}

{%- do salt.log.info(ktorFeatures) -%}
{% for key, feature in ktorFeatures.items() %}
  {% if feature.configurable and feature.selected %}
ktor-feature-config-{{ feature.fileprefix }}:
  {{ createOnlyFile('util',"{}.Conf.kt".format(feature.fileprefix)) }}
  {%- endif -%}
{%- endfor -%}
