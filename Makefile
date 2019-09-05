UID ?= $(shell id -u)
COMPOSE = env UID=$(UID) docker-compose -f docker-compose.yml -f docker-compose.mount-volume.yml

.PHONY: docker-down
docker-down:
	$(COMPOSE) down

.PHONY: docker-build
docker-build:
	$(COMPOSE) build

.PHONY: shell
shell: docker-down docker-build
	$(COMPOSE) run --rm app sh
	docker-compose $(COMPOSE) up -d
	docker-compose exec app sh

.PHONY: spec
spec: docker-down docker-build test lint

.PHONY: test
test: docker-down docker-build
	$(COMPOSE) run --rm echo "fix me"
	docker-compose $(COMPOSE) run --rm app rspec

.PHONY: lint
lint:
	docker-compose $(COMPOSE) run --rm app rubocop

.PHONY: fix
fix:
	docker-compose $(COMPOSE) run --rm app rubocop -a

.PHONY: serve
serve: docker-down docker-build
	$(COMPOSE) run --rm --service-ports app
	docker-compose $(COMPOSE) run --rm --service-ports app
