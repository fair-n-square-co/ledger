-- +goose Up
-- +goose StatementBegin

CREATE TYPE "ledger_direction" AS ENUM ('IN', 'OUT');

CREATE TYPE "transaction_type" AS ENUM ('payment', 'settlement');

CREATE TABLE "ledger" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "user_id" uuid,
  "direction" ledger_direction,
  "amount_currency_code" text NOT NULL DEFAULT 'AUD',
  "amount_units" bigint NOT NULL,
  "amount_nanos" integer NOT NULL,
  "transaction_id" uuid,
  "created_at" timestamptz DEFAULT now(),
  "updated_at" timestamptz DEFAULT now()
);

CREATE TABLE "transaction" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "last_updating_user" uuid,
  "type" transaction_type,
  "created_at" timestamptz DEFAULT now(),
  "updated_at" timestamptz DEFAULT now()
);

ALTER TABLE "ledger" ADD FOREIGN KEY ("transaction_id") REFERENCES "transaction" ("id");

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS "transaction" CASCADE;
DROP TABLE IF EXISTS "ledger" CASCADE;

DROP TYPE ledger_direction;
DROP TYPE transaction_type;
-- +goose StatementEnd
