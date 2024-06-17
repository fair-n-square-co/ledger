package main

import "github.com/fair-n-square-co/ledger/internal/ledger"

func server() {
	ledgerServer := ledger.NewLedgerServer()
	ledgerServer.Start()
}
