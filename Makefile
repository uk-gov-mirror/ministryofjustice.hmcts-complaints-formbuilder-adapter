.PHONY: docker-down
docker-down:
	docker-compose down

.PHONY: docker-build
docker-build:
	docker-compose build

.PHONY: shell
shell: docker-down docker-build
	docker-compose run --rm app sh

.PHONY: test
test: docker-down docker-build
	docker-compose run --rm app rspec

.PHONY: serve
serve: docker-down docker-build
	docker-compose run --rm --service-ports app
