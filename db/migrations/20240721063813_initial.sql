-- +goose Up
-- +goose StatementBegin

CREATE TYPE "transaction_type" AS ENUM ('payment', 'settlement');

CREATE TABLE "share" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "amount_currency_code" text NOT NULL DEFAULT 'AUD',
  "paid_amount_units" bigint NOT NULL,
  "paid_amount_nanos" integer NOT NULL,
  "owed_amount_units" bigint NOT NULL,
  "owed_amount_nanos" bigint NOT NULL,
  "transaction_id" uuid,
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS transaction_share_index ON "share" (transaction_id);

CREATE TABLE "transaction" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "last_updating_user" uuid,
  "type" transaction_type,
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone DEFAULT now()
);

ALTER TABLE "share" ADD FOREIGN KEY ("transaction_id") REFERENCES "transaction" ("id");
-- ALTER TABLE "share" ADD FOREIGN KEY ("transaction_id") REFERENCES transaction (id);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS "transaction" CASCADE;
DROP TABLE IF EXISTS "share" CASCADE;

DROP TYPE transaction_type;
-- +goose StatementEnd
