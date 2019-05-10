#!jinja|yaml
# roles can be defined in grains passed to the instance
{% set roles = grains['roles'] %}
{% if roles is defined %}
include:
{% for role in roles %}
{% if role is defined and role != None and role | length > 0 %}
  - {{ role }}
{% endif %}
{% endfor %}
{% endif %}
