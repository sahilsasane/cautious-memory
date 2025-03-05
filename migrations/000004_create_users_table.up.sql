
CREATE TABLE IF NOT EXISTS users (
    id bigserial PRIMARY KEY,
    created_at timestamp(0) with time ZONE NOT NULL DEFAULT now(),
    name text NOT NULL,
    email text NOT NULL UNIQUE,
    password_hash bytea NOT NULL,
    activated boolean NOT NULL,
    version integer NOT NULL DEFAULT 1
);