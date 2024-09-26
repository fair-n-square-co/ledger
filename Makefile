# DABATASE
GOOSE_DRIVER=postgres
GOOSE_DBSTRING="postgres://postgres:postgres@localhost:5433/ledger?sslmode=disable"

.PHONY: db/start
db/start:
	docker-compose up -d db
	@echo "Waiting for db service to become healthy..."
	@until [ "$$(docker inspect -f {{.State.Health.Status}} $$(docker-compose ps -q db))" = "healthy" ]; do \
		sleep 1; \
	done
	@echo "db service is healthy!"

.PHONY: db/client
db/client: db/start
	docker compose exec db psql -U postgres -d ledger

.PHONY: db/up
db/up: db/start
	goose -dir db/migrations postgres $(GOOSE_DBSTRING) up

.PHONY: db/create
db/create:
	goose -dir db/migrations create $(name) sql

.PHONY: db/down
db/down:
	goose -dir db/migrations postgres $(GOOSE_DBSTRING) down

.PHONY: db/gen
db/gen:
	sqlc generate

# SERVICE
.PHONY: build
build:
	go build -o bin/ledger ./cmd/ledger

.PHONY: run
run: build
	@echo "Starting server..."
	./bin/ledger

.PHONY: dev
dev: db/up
	@echo "Watching for changes..."
	@air
