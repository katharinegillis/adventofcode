nginx_install:
  pkg.installed:
    - name: nginx
  service.running:
    - name: nginx
    - require:
      - pkg: nginx_install
    - watch:
      - file: nginx_config
      - file: nginx_site_config
      - file: nginx_enable_default_site

nginx_config:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx_install

nginx_site_config:
  file.managed:
    - name: /etc/nginx/sites-available/default
    - source: salt://nginx/default
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx_install

nginx_enable_default_site:
  file.symlink:
    - name: /etc/nginx/sites-enabled/default
    - target: /etc/nginx/sites-available/default
    - require:
      - pkg: nginx_install