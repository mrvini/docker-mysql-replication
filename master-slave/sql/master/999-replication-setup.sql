USE mysql;
CREATE USER 'replication'@'%' IDENTIFIED BY 'replic@t10n';
-- GRANT SELECT, PROCESS, FILE, SUPER, REPLICATION CLIENT, REPLICATION SLAVE, RELOAD ON *.* TO 'replicator'@'%';
GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';
-- do note that the replicator permission cannot be granted on single database.
FLUSH PRIVILEGES;
-- SHOW MASTER STATUS;
-- SHOW VARIABLES LIKE 'server_id';
