#!/bin/bash

generate_password() {
  echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
}

export HOST=k86.eu

export PASS_INFLUXDB=$(generate_password)
export PASS_GRAFANA=$(generate_password)

echo "PASS_INFLUXDB = ${PASS_INFLUXDB}"
echo "PASS_GRAFANA = ${PASS_GRAFANA}"

docker-compose up
