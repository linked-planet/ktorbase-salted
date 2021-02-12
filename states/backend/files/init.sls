{% set basePath = pillar.basePath %}
{% set projectName = pillar.projectName %}

project-folder:
  file.directory: 
    - name: {{ basePath }}/{{ projectName }}

backend-folder:
  file.directory: 
    - name: {{ basePath }}/{{ projectName }}/backend
    - require:
      - file: {{ basePath }}/{{ projectName }}


include:
  - ./main
  - ./test
  - ./build


