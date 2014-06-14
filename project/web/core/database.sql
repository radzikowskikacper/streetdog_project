-- script file nr #1



-- add new database
DROP DATABASE IF EXISTS streetdog;
CREATE DATABASE streetdog;


-- set database
USE streetdog;


-- create events table
drop table if exists events;
create table events ( id BIGINT NOT NULL, point_lat DOUBLE PRECISION NOT NULL,point_lon DOUBLE PRECISION NOT NULL, event_type TINYINT NOT NULL, time datetime NOT NULL, acc DOUBLE NOT NULL , PRIMARY KEY (id) );
#ALTER TABLE events ADD CONSTRAINT my_key_1 FOREIGN KEY (event_type) references event_types (id);

-- create users table
drop table if exists users;
create table users ( id BIGINT NOT NULL, last_request datetime  NOT NULL, PRIMARY KEY (id) );

-- create route table (for users)
drop table if exists routes;
create table routes ( id BIGINT NOT NULL, user_id BIGINT NOT NULL, point_lat DOUBLE PRECISION NOT NULL, point_lon DOUBLE PRECISION NOT NULL, PRIMARY KEY (id));
ALTER TABLE routes ADD CONSTRAINT my_key_1 FOREIGN KEY (user_id) references users (id);
