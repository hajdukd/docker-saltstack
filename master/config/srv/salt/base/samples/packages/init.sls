#!jinja|yaml
{% set packages = pillar.get('packages', None) %}
{% if packages %}
{% for package in packages %}
{{ package }}:
  pkg.installed
{% endfor %}
{% endif %}
