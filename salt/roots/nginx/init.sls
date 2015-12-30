nginx_install:
  pkg.installed:
    - name: nginx
  service.running:
    - name: nginx
    - require:
      - pkg: nginx_install
    - watch:
      - file: nginx_old_default_config
      - file: nginx_config
      - file: nginx_site_config
      - file: nginx_enable_default_site

nginx_old_default_config:
  file.absent:
    - name: /etc/nginx/conf.d/default.conf
    - require:
      - pkg: nginx_install

nginx_config:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx_install
      - file: nginx_old_default_config

nginx_sites_available_directory:
  file.directory:
    - name: /etc/nginx/sites-available
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - makedirs: true
    - require:
      - pkg: nginx_install

nginx_site_config:
  file.managed:
    - name: /etc/nginx/sites-available/default.conf
    - source: salt://nginx/default.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: nginx_sites_available_directory

nginx_sites_enabled_directory:
  file.directory:
    - name: /etc/nginx/sites-enabled
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - makedirs: true
    - require:
      - pkg: nginx_install

nginx_enable_default_site:
  file.symlink:
    - name: /etc/nginx/sites-enabled/default.conf
    - target: /etc/nginx/sites-available/default.conf
    - require:
      - file: nginx_sites_enabled_directory