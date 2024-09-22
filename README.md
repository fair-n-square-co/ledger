## Requirements

- Goose
```bash
go install github.com/pressly/goose/v3/cmd/goose@latest
```

Will need this in the PATH:
```bash
export PATH=$PATH:$(go env GOPATH)/bin
```

### Database setup:

```bash
# Run the migrations
make db/up

# Start DB client
make db/client

# Generate go code for SQL queries
make db/gen
```

### Dev setup:

```bash
make db/start db/up dev
```
