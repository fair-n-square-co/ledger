# DABATASE
GOOSE_DRIVER=postgres
GOOSE_DBSTRING="postgres://postgres:postgres@localhost:5433/ledger?sslmode=disable"

.PHONY: db/up
db/up:
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
.Phony: build
build:
	go build -o bin/ledger ./cmd/ledger

.Phony: run
run: build
	@echo "Starting server..."
	./bin/ledger
