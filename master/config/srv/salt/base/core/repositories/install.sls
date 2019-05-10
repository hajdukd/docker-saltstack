#!jinja|yaml
{% set repositories = pillar.get('repositories', {}) %}
{% for repo_name, repo_properties in repositories.iteritems() %}
repo-{{ repo_name }}:
  pkgrepo.managed:
    - name: {{ repo_name }}
  {% for key, value in repo_properties.iteritems() %}
    - {{ key }}: {{ value }}
  {% endfor %}
  {% if not 's3_enabled' in repo_properties and (repo_properties.baseurl | string | regex_match('(.*?)?s3(-.*?)?\.amazonaws\.com', ignorecase=True)) %}
    - s3_enabled: 1
  {% if not 'skip_if_unavailable' in repo_properties %}
    - skip_if_unavailable: True
  {% endif %}
  {% endif %}
{% endfor %}