{%- set basePath = "{}/{}".format(pillar.basePath, pillar.projectName) -%}
{%- set groupId = pillar.groupId | join('.') -%}
{%- set groupPath = pillar.groupId | join('/') | replace('-','') -%}
{%- set packageId = pillar.groupId | join('.') | replace('-','') -%}
{%- set projectName = pillar.projectName -%}
{%- set ktorFeatures = pillar.modules.backend.ktor.server.features -%}
{%- set sourceMainDir = "{}/common/src/main/kotlin/{}/{}".format(basePath, groupPath, pillar.projectName) -%}
{%- set sourcePath = "salt://common/src" -%}

{% from 'lib.sls' import subDir, createOnlyFile with context %}

common-base-directory:
  file.directory:
    - name: {{ basePath }}/common
    - mode: 755
    - makedirs: True

common-source-directory:
  file.directory:
    - name: {{ sourceMainDir }}
    - mode: 755
    - makedirs: True
    - require:
      - file: {{ basePath }}/common

build-file-common:
  file.managed:
    - name: {{ basePath }}/common/build.gradle.kts
    - source: salt://common/build.gradle.kts.jinja
    - template: jinja
    - require:
      - file: {{ basePath }}/common

{{ subDir('model') }}
{{ subDir('routes') }}

{{ createOnlyFile('model','Model.kt') }}

{{ createOnlyFile('routes','Requests.kt') }}
{{ createOnlyFile('routes','Responses.kt') }}
