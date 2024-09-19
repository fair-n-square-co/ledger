## Requirements

- Goose
```bash
go install github.com/pressly/goose/v3/cmd/goose@latest
```

Will need this in the PATH:
```bash
export PATH=$PATH:$(go env GOPATH)/bin
```

Start the database:

```bash
make db/up
```

Run the server:

```bash
make run
```
