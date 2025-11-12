USE gestorgcomp;
SET FOREIGN_KEY_CHECKS=0;
SOURCE /docker-entrypoint-initdb.d/dump_temp.sql.data;
SET FOREIGN_KEY_CHECKS=1;
