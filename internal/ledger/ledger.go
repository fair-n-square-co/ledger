package ledger

import "fmt"

type LedgerServer struct {
}

func (l *LedgerServer) Start() {
	fmt.Println("Starting a transaction!!!")
}

func NewLedgerServer() *LedgerServer {
	return &LedgerServer{}
}
