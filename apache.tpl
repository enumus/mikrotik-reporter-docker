<VirtualHost *:80>
    # Python application integration
    WSGIDaemonProcess main processes=4 threads=20
    WSGIScriptAlias / "/app/main.wsgi"

    <Directory "/app/">
        Options Indexes FollowSymLinks MultiViews ExecCGI
        AllowOverride None
        Require all granted
        WSGIProcessGroup main
        WSGIApplicationGroup %{GLOBAL}
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    LogLevel warn
    CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>