{%- macro subDir(dirname) -%}
subdir-{{ dirname }}:
  file.directory:
    - name: {{ sourceMainDir }}/{{ dirname }}
    - mode: 755
    - require:
      - file: {{ sourceMainDir }}
{%- endmacro -%}

{%- macro createOnlyFile(relativePath, baseName) -%}
  file.managed:
    - name: {{ sourceMainDir }}/{{ relativePath }}/{{ baseName }}
    - source: {{ sourcePath }}/{{ relativePath }}/{{ baseName }}.jinja
    - template: jinja
    - replace: False
    - context:
      packageId: {{ packageId }}
      projectName: {{ projectName }}
{%- endmacro -%}

{%- macro iterateSettingsFlat(settings) -%}
  {%- for name,value in settings.items() %}
    {{ name }} = "{{ value.default }}"
    {%- if value.optional -%}
        {%- set qu = '{?' -%}
    {%- else -%}
        {%- set qu = '{' -%}
    {%- endif %}
    {{ name }} = ${{ qu }}{{ value.envName }}}
  {% endfor %}
{%- endmacro -%}
