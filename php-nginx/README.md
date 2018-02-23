# Nginx

## Usage 

`````
nginx:
    image: donkeycode/php-nginx
    ports:
      - "8099:80"
    environment:
      WEBDIR: /var/www/symfony/web
      CONTROLLER_NAME: app_dev
    links:
      - php
    volumes:
      - xxx-code-sync:/var/www/symfony:rw
`````

