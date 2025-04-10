// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: query.sql

package sqlc

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

const createShare = `-- name: CreateShare :one
INSERT INTO "share" (user_id, amount_currency_code, paid_amount_units, paid_amount_nanos, owed_amount_units, owed_amount_nanos, transaction_id)
VALUES ($1, $2, $3, $4, $5, $6, $7)
RETURNING id, user_id, amount_currency_code, paid_amount_units, paid_amount_nanos, owed_amount_units, owed_amount_nanos, transaction_id, created_at, updated_at
`

type CreateShareParams struct {
	UserID             pgtype.UUID
	AmountCurrencyCode string
	PaidAmountUnits    int64
	PaidAmountNanos    int32
	OwedAmountUnits    int64
	OwedAmountNanos    int64
	TransactionID      pgtype.UUID
}

func (q *Queries) CreateShare(ctx context.Context, arg CreateShareParams) (Share, error) {
	row := q.db.QueryRow(ctx, createShare,
		arg.UserID,
		arg.AmountCurrencyCode,
		arg.PaidAmountUnits,
		arg.PaidAmountNanos,
		arg.OwedAmountUnits,
		arg.OwedAmountNanos,
		arg.TransactionID,
	)
	var i Share
	err := row.Scan(
		&i.ID,
		&i.UserID,
		&i.AmountCurrencyCode,
		&i.PaidAmountUnits,
		&i.PaidAmountNanos,
		&i.OwedAmountUnits,
		&i.OwedAmountNanos,
		&i.TransactionID,
		&i.CreatedAt,
		&i.UpdatedAt,
	)
	return i, err
}

const createTransaction = `-- name: CreateTransaction :one
INSERT INTO "transaction" (type, last_updating_user)
VALUES ($1, $2)
RETURNING id, last_updating_user, type, created_at, updated_at
`

type CreateTransactionParams struct {
	Type             NullTransactionType
	LastUpdatingUser pgtype.UUID
}

func (q *Queries) CreateTransaction(ctx context.Context, arg CreateTransactionParams) (Transaction, error) {
	row := q.db.QueryRow(ctx, createTransaction, arg.Type, arg.LastUpdatingUser)
	var i Transaction
	err := row.Scan(
		&i.ID,
		&i.LastUpdatingUser,
		&i.Type,
		&i.CreatedAt,
		&i.UpdatedAt,
	)
	return i, err
}

const getTransactionAndShares = `-- name: GetTransactionAndShares :many
SELECT t.id, t.last_updating_user, t.type, t.created_at, t.updated_at, s.id, s.user_id, s.amount_currency_code, s.paid_amount_units, s.paid_amount_nanos, s.owed_amount_units, s.owed_amount_nanos, s.transaction_id, s.created_at, s.updated_at
FROM "transaction" t
JOIN "share" s ON t.id = s.transaction_id
WHERE t.id = $1
`

type GetTransactionAndSharesRow struct {
	ID                 pgtype.UUID
	LastUpdatingUser   pgtype.UUID
	Type               NullTransactionType
	CreatedAt          pgtype.Timestamptz
	UpdatedAt          pgtype.Timestamptz
	ID_2               pgtype.UUID
	UserID             pgtype.UUID
	AmountCurrencyCode string
	PaidAmountUnits    int64
	PaidAmountNanos    int32
	OwedAmountUnits    int64
	OwedAmountNanos    int64
	TransactionID      pgtype.UUID
	CreatedAt_2        pgtype.Timestamptz
	UpdatedAt_2        pgtype.Timestamptz
}

func (q *Queries) GetTransactionAndShares(ctx context.Context, id pgtype.UUID) ([]GetTransactionAndSharesRow, error) {
	rows, err := q.db.Query(ctx, getTransactionAndShares, id)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []GetTransactionAndSharesRow
	for rows.Next() {
		var i GetTransactionAndSharesRow
		if err := rows.Scan(
			&i.ID,
			&i.LastUpdatingUser,
			&i.Type,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.ID_2,
			&i.UserID,
			&i.AmountCurrencyCode,
			&i.PaidAmountUnits,
			&i.PaidAmountNanos,
			&i.OwedAmountUnits,
			&i.OwedAmountNanos,
			&i.TransactionID,
			&i.CreatedAt_2,
			&i.UpdatedAt_2,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
