
.PHONY: help

help:
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

up: ## Starts all the containers required run the demo
	docker-compose up -d

test: ## Execute unit tests
	docker run -v `pwd`/docker/vector/:/etc/vector/ timberio/vector:0.12.1-alpine test /etc/vector/*.toml

attack: ## Run HTTP requests to fill Clickhouse
	docker run --network container:kong --name attack --rm -i peterevans/vegeta sh -c \
	"echo 'GET http://kong:8000/mypath' | vegeta attack -rate=1000 -duration=15s -header=apikey:my-key | vegeta report"

query: ## Run query against Clickhouse
	docker-compose exec clickhouse bash -c "echo 'SELECT consumer_username AS u, count() c, quantile(0.95)(latency_kong) AS lk_p95, quantile(0.95)(latency_proxy) AS lp_p95 FROM kong.log GROUP BY u FORMAT PrettyCompactMonoBlock' | clickhouse-client -m -n"

down: ## Shuts down all the containers and removes their volume
	docker-compose down --volumes --remove-orphans