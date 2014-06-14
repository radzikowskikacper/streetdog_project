-- script file nr #2


-- add zpr's user
DROP USER 'streetdog'@'localhost';
CREATE USER 'streetdog'@'localhost' IDENTIFIED BY 'kiloslim';


-- grant privileges to zpr
GRANT ALL PRIVILEGES ON streetdog.* TO 'streetdog'@'localhost';

