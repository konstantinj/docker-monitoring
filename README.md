# Docker monitoring stack

This docker stack contains elasticsearch, logstash, kibana, cadvisor, logspout, collectd, influxdb and grafana. Pretty much all tools you will need to monitor the performance of you docker host, your docker containers and for log aggregation.

Please take a look at the used images for more information.

## Dependencies

I'm using [nginx-proxy](https://github.com/jwilder/nginx-proxy) to access kibana, grafana and cadvisor. This image is using the ENV vars VIRTUAL_* to setup the proxy config. You can just start this image as independent container and provide a host in HOST (see start.sh).

## Usage

When using docker-compose directly to start the stack you have to export these shell variables before:

```bash
export PASS_INFLUXDB=secret
export PASS_GRAFANA_secret

docker-compose up
```

For convenience I've provided a shell script that generated passwords. So you can just use:

```bash
./start.sh
```

## How it works

Logspout is aggregating logs from all containers (without the LOGSPOUT=ignore ENV) and sends the data to logstash. Logstash is forwarding data to elasticsearch which you can then see in Kibana.
Collectd is collecting logs from the host and all docker containers with the COLLECTD_DOCKER_APP ENV. It's sending the data to logstash and influxdb. So you are able to use the metric data in Kibana together with log data and in grafana which as influxdb as pre defined datasource.
Cadvisor is just included as long as there are no pregenerated dashboards.

## TODO

Currently there are no pregenerated dashboards in kibana and grafana. Still on it.
