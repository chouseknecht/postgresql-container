{% if postgres_db != 'postgres' %}
CREATE DATABASE "{{ postgres_db }}";
{% endif %}
{% if postgres_user == 'postgres' %}
ALTER USER postgres with SUPERUSER {{ postgres_pass }};
{% else %}
CREATE USER "{{ postgres_user }}" WITH SUPERUSER PASSWORD '{{ postgres_pass }}';
{% endif %}
