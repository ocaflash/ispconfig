cd /tmp
cd ispconfig3_install/install/
export passwd_isp=$(pwgen 16 1)
export passwd_db=$(pwgen 16 1)
echo -e "[install]\nlanguage=en\ninstall_mode=standard\nhostname=$(hostname -f)\nmysql_hostname=localhost\nmysql_port=3306\nmysql_root_user=root\nmysql_root_password=$passwd_root\nmysql_database=dbispconfig\nmysql_charset=utf8\nhttp_server=nginx\nispconfig_port=81\nispconfig_use_ssl=n\nispconfig_admin_password=$passwd_isp\n\n[ssl_cert]\nssl_cert_country=RU\nssl_cert_state=Moscow\nssl_cert_locality=Moscow\nssl_cert_organisation=\nssl_cert_organisation_unit=\nssl_cert_common_name=$(hostname -f)\nssl_cert_email=hostmaster@$(hostname -f)\n\n[expert]\nmysql_ispconfig_user=ispconfig\nmysql_ispconfig_password=$passwd_db\njoin_multiserver_setup=n\nmysql_master_hostname=localhost\nmysql_master_root_user=root\nmysql_master_root_password=''\nmysql_master_database=dbispconfig\nconfigure_mail=y\nconfigure_jailkit=y\nconfigure_ftp=y\nconfigure_dns=n\nconfigure_apache=n\nconfigure_web=y\nconfigure_nginx=y\nconfigure_firewall=y\ninstall_ispconfig_web_interface=y" > autoinstall.ini
php install.php --autoinstall=autoinstall.ini
echo -e "admin $passwd_isp\n$passwd_root" > ~/.ispconfig.ini
echo -e 'User-Agent: *\nDisallow: /' > /var/www/robots.txt
mkdir /etc/systemd/system/openvpn-client@.service.d
echo -e '[Service]\nRestart=always\nRestartSec=10000ms\nStartLimitInterval=0' > /etc/systemd/system/openvpn-client@.service.d/autorestart.conf
