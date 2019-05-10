#!jinja|yaml
{% set packages = pillar.get('packages', {}) %}
{% for package_name, package_properties in packages.iteritems() %}
{{ package_name }}:
  {% if 'version' in package_properties or 'fromrepo' in package_properties %}
  pkg.installed:
  {% else %}
  pkg.installed
  {% endif %}
    {% if 'version' in package_properties %}
    - version: {{ package_properties['version'] }}
    {% endif %}
    {% if 'fromrepo' in package_properties %}
    - fromrepo: {{ package_properties['fromrepo'] }}
    {% endif %}
{% endfor %}
