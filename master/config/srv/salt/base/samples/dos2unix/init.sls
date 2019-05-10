{% set d2u_properties = pillar.get('dos2unix', {}) %}
dos2unix:
  pkg.installed:
  {% if d2u_properties.version is defined %}
    - version: {{ d2u_properties.version }}
  {% endif %}
