# cleanup
docker rm -f db.slave db.master

echo '-> Starting Master Container....'
# master
docker run -d \
    --name db.master \
    --restart=always \
    -v $(pwd)/cnf/master:/etc/mysql/mysql.conf.d  \
    -v $(pwd)/sql/master/:/docker-entrypoint-initdb.d \
    -e MYSQL_ROOT_PASSWORD=admin \
    -e MYSQL_DATABASE=testing \
    -e MYSQL_USER=test-user \
    -e MYSQL_PASSWORD=test-password \
    mysql:5.7.21

sleep 10 # introducing delay so its enought time for master to start
echo '-> Master Container started....'

echo '-> Starting Slave Container....'
# slave
docker run -d \
    --name db.slave \
    --restart=always \
    --link db.master \
    -v $(pwd)/cnf/slave:/etc/mysql/mysql.conf.d  \
    -v $(pwd)/sql/slave/:/docker-entrypoint-initdb.d  \
    -e MYSQL_ROOT_PASSWORD=admin \
    mysql:5.7.21

sleep 5
echo '-> Slave Container started, getting slave status....'

docker exec -it db.slave sh -c "mysql -u root --password=admin -e 'SHOW SLAVE STATUS'"
# output slave status
