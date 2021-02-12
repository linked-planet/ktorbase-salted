{% set basePath = pillar.basePath %}
{% set projectName = pillar.projectName %}

build-file-backend:
  file.managed:
    - name: {{ basePath }}/{{ projectName }}/backend/build.gradle.kts
    - source: salt://backend/files/build.gradle.kts.jinja
    - template: jinja
    - require:
      - file: {{ basePath }}/{{ projectName }}/backend
