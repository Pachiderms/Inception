CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_pass_42';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'super_root_pwd';
FLUSH PRIVILEGES;
