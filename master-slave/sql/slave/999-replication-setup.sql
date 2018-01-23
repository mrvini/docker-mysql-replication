USE mysql;
CREATE USER 'replication'@'%' IDENTIFIED BY 'replic@t10n';
GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';
-- do note that the replicator permission cannot be granted on single database.
FLUSH PRIVILEGES;
CHANGE MASTER TO
    MASTER_HOST='db.master',
    MASTER_USER='replication',
    MASTER_PASSWORD='replic@t10n';
START SLAVE;
-- SHOW SLAVE STATUS;
-- SHOW VARIABLES LIKE 'server_id';
-- FLUSH TABLES WITH READ LOCK;
SET GLOBAL read_only = ON;
SET GLOBAL super_read_only = ON;
