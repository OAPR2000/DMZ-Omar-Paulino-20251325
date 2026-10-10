-- DB-SERVER (10.13.25.146) - MySQL
-- Ejecutar con: sudo mysql < db-server_setup.sql
USE tienda;
DROP USER IF EXISTS 'webuser'@'10.13.25.130';
CREATE USER 'webuser'@'10.13.25.147' IDENTIFIED WITH mysql_native_password BY 'Web1325!Pass';
CREATE USER 'webuser'@'10.13.25.148' IDENTIFIED WITH mysql_native_password BY 'Web1325!Pass';
GRANT SELECT ON tienda.* TO 'webuser'@'10.13.25.147';
GRANT SELECT ON tienda.* TO 'webuser'@'10.13.25.148';
ALTER TABLE productos ADD COLUMN stock INT NOT NULL DEFAULT 0;
UPDATE productos SET stock = 12 WHERE id = 1;
UPDATE productos SET stock = 80 WHERE id = 2;
UPDATE productos SET stock = 45 WHERE id = 3;
DROP TABLE IF EXISTS usuarios;
FLUSH PRIVILEGES;
