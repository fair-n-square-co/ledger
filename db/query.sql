-- name: GetLedger :one
SELECT * FROM ledger
WHERE id = $1 LIMIT 1;

-- name: GetTransaction :one
SELECT * FROM transaction
JOIN ledger ON transaction.id = ledger.transaction_id
WHERE transaction.id = $1 LIMIT 1;

-- name: GetLedgers :many
