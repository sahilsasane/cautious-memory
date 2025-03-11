include .envrc

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: print this help message
.PHONY: help
help:
	@echo "Usage:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

.PHONY: confirm
confirm:
	@echo -n 'Are you sure? [y/N] ' && read ans && [ $${ans:-N} = y ]

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #

## run/api: run the cmd/api application
.PHONY: run/api
run/api:
	go run ./cmd/api -db-dsn=${GREENLIGHT_DB_DSN}

## db/psql: connect to the database using psql
.PHONY: db/psql
db/psql:
	psql ${GREENLIGHT_DB_DSN}

## db/migrations/new name=$1: create a new database migration
.PHONY: db/migrations/new
db/migrations/new:
	@echo "Creating new migration"
	migrate create -seq -ext=.sql -dir=./migrations $(name)

## db/migrations/up: apply all up database migrations
.PHONY: db/migrations/up
db/migrations/up: confirm
	@echo "Running up migrations"
	migrate -path ./migrations -database ${GREENLIGHT_DB_DSN} up

## db/check: check database connection and print current DSN
.PHONY: db/check
db/check:
	@echo "Current DB DSN: ${GREENLIGHT_DB_DSN}"
	@echo "Checking database connection..."
	@psql ${GREENLIGHT_DB_DSN} -c "SELECT version();" || echo "Connection failed!"
	
# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## audit: tidy dependencies and format, vet and test all code
.PHONY: audit
audit:
	@echo "Formatting code"
	go fmt ./...
	@echo "Vetting code"
	go vet ./...
	staticcheck ./...
	@echo "Running tests"
	go test -race -vet=off ./...

.PHONY: vendor
vendor:
	@echo "Tidying and verifying module dependencies"
	go mod tidy
	go mod verify
	@echo "Vendoring dependencies"
	go mod vendor