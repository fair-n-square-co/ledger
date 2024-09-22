-- name: CreateTransaction :one
INSERT INTO "transaction" (type, last_updating_user)
VALUES ($1, $2)
RETURNING *;

-- name: CreateShare :one
INSERT INTO "share" (user_id, amount_currency_code, paid_amount_units, paid_amount_nanos, owed_amount_units, owed_amount_nanos, transaction_id)
VALUES ($1, $2, $3, $4, $5, $6, $7)
RETURNING *;

-- name: GetTransactionAndShares :many
SELECT t.*, s.*
FROM "transaction" t
JOIN "share" s ON t.id = s.transaction_id
WHERE t.id = $1;
