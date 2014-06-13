-- script file nr #2


-- add zpr's user
DROP USER 'zpr'@'localhost';
CREATE USER 'zpr'@'localhost' IDENTIFIED BY 'zpr';


-- grant privileges to zpr
GRANT ALL PRIVILEGES ON streetguard.* TO 'zpr'@'localhost';

