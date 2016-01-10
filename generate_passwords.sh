#!/bin/bash

generate_password() {
  echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
}

PASS_GRAFANA=$(generate_password)
PASS_INFLUXDB=$(generate_password)

sed -i -e "s/\(GF_SECURITY_ADMIN_PASSWORD\)=.*/\1=${PASS_GRAFANA}/" docker-compose.yml
sed -i -e "s/\(API_PASS\)=.*/\1=${PASS_GRAFANA}/" docker-compose.yml
sed -i -e "s/\(INFLUXDB_INIT_PWD\)=.*/\1=${PASS_INFLUXDB}/" docker-compose.yml
sed -i -e "s/\(DS_PASSWORD\)=.*/\1=${PASS_INFLUXDB}/" docker-compose.yml
