nodejs_install:
  pkg.installed:
    - pkgs:
      - nodejs
      - npm

nodejs_nodemon_install:
  cmd.run:
    - name: "npm install -g nodemon"
    - require:
      - pkg: nodejs_install

nodejs_coffeescript_install:
  cmd.run:
    - name: "npm install -g coffee-script"
    - require:
      - pkg: nodejs_install