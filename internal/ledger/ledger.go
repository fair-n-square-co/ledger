package ledger

import (
	"fmt"

	ledgerpb "github.com/fair-n-square-co/apis/gen/pkg/fairnsquare/service/transaction/v1alpha1"
)

type LedgerServer struct {
	ledgerpb.UnimplementedTransactionServiceServer
}

func (l *LedgerServer) Start() {
	fmt.Println("Starting a transaction!!!")
}

func NewLedgerServer() *LedgerServer {
	return &LedgerServer{}
}
