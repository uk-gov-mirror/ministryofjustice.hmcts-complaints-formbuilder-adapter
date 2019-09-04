DOCKER_COMPOSE_FILES=-f docker-compose.yml -f docker-compose.mount-volume.yml

.PHONY: docker-down
docker-down:
	docker-compose down

.PHONY: docker-build
docker-build:
	docker-compose build

.PHONY: shell
shell: docker-down docker-build
	docker-compose $(DOCKER_COMPOSE_FILES) up -d
	docker-compose exec app sh

.PHONY: spec
spec: docker-down docker-build test lint

.PHONY: test
test: docker-down docker-build
	docker-compose $(DOCKER_COMPOSE_FILES) run --rm app rspec

.PHONY: lint
lint:
	docker-compose $(DOCKER_COMPOSE_FILES) run --rm app rubocop

.PHONY: fix
fix:
	docker-compose $(DOCKER_COMPOSE_FILES) run --rm app rubocop -a

.PHONY: serve
serve: docker-down docker-build
	docker-compose $(DOCKER_COMPOSE_FILES) run --rm --service-ports app
