{%- set basePath = "{}/{}".format(pillar.basePath, pillar.projectName) -%}
{%- set groupId = pillar.groupId | join('.') -%}
{%- set groupPath = pillar.groupId | join('/') | replace('-','') -%}
{%- set packageId = pillar.groupId | join('.') | replace('-','') -%}
{%- set projectName = pillar.projectName -%}
{%- set ktorFeatures = pillar.modules.backend.ktor.server.features -%}
{%- set sourceMainDir = "{}/backend/src/main/resources".format(basePath) -%}
{%- set sourcePath = "salt://backend/files/main/resources" -%}

{% from 'lib.sls' import createOnlyFile with context %}

resource-directory:
  file.directory:
    - name: {{ sourceMainDir }}
    - mode: 755
    - makedirs: True
    - require:
      - file: {{ basePath }}/backend

logback-config:
  file.managed:
    - name: {{ sourceMainDir }}/logback.xml
    - source: {{ sourcePath }}/logback.xml

application-config:
  file.managed:
    - name: {{ sourceMainDir }}/application.conf
    - source: {{ sourcePath }}/application.conf.jinja
    - template: jinja


{%- if ktorFeatures.saml.selected %}
saml-config:
  file.managed:
    - name: {{ sourceMainDir }}/saml.conf
    - source: {{ sourcePath }}/saml.conf.jinja
    - template: jinja
{%- endif %}

{%- if ktorFeatures.sessions.selected %}
session-config:
  file.managed:
    - name: {{ sourceMainDir }}/session.conf
    - source: {{ sourcePath }}/session.conf.jinja
    - template: jinja
{%- endif %}
