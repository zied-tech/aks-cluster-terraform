## Login into MySQL database root user
sudo mysql -uroot -proot

## Create a new user with name zied and password zied
CREATE USER 'zied'@'localhost' IDENTIFIED BY 'zied';
GRANT ALL PRIVILEGES on *.* to 'zied'@'localhost';
FLUSH PRIVILEGES;

## Now login to zied user and run the mysql-db-export.sql script
sudo mysql -uzied -pzied
