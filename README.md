# Demo Vector's Clickhouse sink component to store Kong logs

This demo shows how to use [Vector](http://vector.dev/) to store [Kong API Gateway](https://konghq.com/kong/) request details in [Clickhouse](https://clickhouse.tech/).

## Requirements

* `docker`
* `docker-compose`
* `make` (unless you want to launch the commands manually)

## Run it

The Makefile is self documented. Type make help to get its content:

```text
up                             Starts all the containers required run the demo
test                           Execute unit tests
attack                         Run HTTP requests to fill Clickhouse
query                          Run query against Clickhouse
down                           Shuts down all the containers and removes their volume
```

Execute the commands in this order to run the demo.
