{%- set basePath = "{}/{}".format(pillar.basePath, pillar.projectName) -%}
{%- set sourceMainDir = "{}/backend/src/test/resources".format(basePath) -%}
{%- set sourcePath = "salt://backend/files/test/resources" -%}

{% from 'lib.sls' import createOnlyFile with context %}

test-resource-directory:
  file.directory:
    - name: {{ sourceMainDir }}
    - mode: 755
    - makedirs: True
    - require:
      - file: {{ basePath }}/backend


{% if pillar.modules.test.jmeter.use -%}
test-jmeter-config:
  file.managed:
    - name: {{ sourceMainDir }}/TemplateTest.jmx
    - source: {{ sourcePath }}/TemplateTest.jmx
{%- endif -%}
