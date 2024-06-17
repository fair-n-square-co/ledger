.Phony: build
build:
	go build -o bin/ledger ./cmd/ledger

.Phony: run
run: build
	@echo "Starting server..."
	./bin/ledger
