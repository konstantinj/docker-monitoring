# Docker monitoring stack

This docker stack contains elasticsearch, logstash, kibana, logspout, collectd, gcp, influxdb and grafana. Pretty much all tools you will need to monitor the performance of you docker host, your docker containers and for log aggregation.

Please take a look at the used images for more information.

## Dependencies

I'm using [nginx-proxy](https://github.com/jwilder/nginx-proxy) to access kibana, grafana and cgp. This image is using the ENV vars VIRTUAL_* to setup the proxy config. Please change them to be able to access containers.

## Usage

You may want to run generate_passwords.sh to generate some random passwords for your services.
Afterwards you can just use docker-compose to start.

```bash
./generate_passwords.sh
docker-compose up
```

## How it works

Logspout is aggregating logs from all containers (without the LOGSPOUT=ignore ENV) and sends the data to logstash. Logstash is forwarding data to elasticsearch which you can then see in Kibana.
Collectd is collecting logs from the host and all docker containers with the COLLECTD_DOCKER_APP ENV. It's sending the data to logstash and influxdb. So you are able to use the metric data in Kibana together with log data and in grafana which as influxdb as pre defined datasource.
Grafana comes with predefined dashboards to monitor the host and docker containers.
