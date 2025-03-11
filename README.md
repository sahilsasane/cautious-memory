# Cautious Memory

## Overview

**Cautious Memory** is a Go-based API project designed with a focus on clean architecture, security, and scalability. It provides basic functionalities such as user registration, authentication, and movie management. The project aims to demonstrate best practices in Go development, including structured logging, rate limiting, and graceful shutdown.

## Features

- **User Management**: User registration, activation, and authentication.
- **Movie Management**: CRUD operations for movies.
- **Token-Based Authentication**: Secure token-based authentication system with JWT.
- **Rate Limiting**: IP-based rate limiting to prevent abuse.
- **Structured Logging**: JSON logging for better observability.
- **Graceful Shutdown**: Proper server shutdown with connection draining.
- **Email Support**: User activation via email system.
- **Environment Configuration**: Configurable settings via flags and environment variables.

## Project Structure

```
cautious-memory/
├── cmd/
│   └── api/                   # Application entry point & HTTP handlers
│       ├── main.go            # Main application entry point
│       ├── server.go          # HTTP server setup and graceful shutdown
│       ├── routes.go          # API routing definitions
│       ├── movies.go          # Movie-specific handlers
│       ├── users.go           # User-specific handlers
│       ├── tokens.go          # Authentication token handlers
│       └── middleware.go      # HTTP middleware components
└── internal/                  # Internal packages
    ├── data/                  # Data models and database interactions
    │   ├── models.go          # Model definitions and factory
    │   ├── movies.go          # Movie model and DB operations
    │   ├── users.go           # User model and DB operations
    │   └── tokens.go          # Token model and DB operations
    ├── jsonlog/               # JSON logging package
    ├── validator/             # Request validation
    └── mailer/                # Email functionality
```

## Requirements

- Go 1.18 or higher
- PostgreSQL

## Getting Started

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/sahilsasane/cautious-memory.git
    cd cautious-memory
    ```

2. Install dependencies:
    ```sh
    go mod download
    ```

3. Set up environment variables:
    ```sh
    cp .env.example .env
    # Edit .env file with your configuration
    ```

4. Run database migrations (assuming you have a PostgreSQL server running):
    ```sh
    migrate -path ./migrations -database postgres://user:password@localhost:5432/cautious_memory up
    ```

### Running the Server

Start the server:
```sh
go run cmd/api/main.go
```

## API Endpoints

### Movies

- `GET /v1/healthcheck`: System health check
- `GET /v1/movies`: List movies with filtering and pagination
- `POST /v1/movies`: Create a new movie
- `GET /v1/movies/:id`: Get a specific movie
- `PATCH /v1/movies/:id`: Update a movie
- `DELETE /v1/movies/:id`: Delete a movie

### Users & Authentication

- `POST /v1/users`: Register a new user
- `PUT /v1/users/activated`: Activate a user account
- `POST /v1/tokens/authentication`: Generate authentication tokens

## Makefile

### Commands

- **help**: Print this help message.
- **run/api**: Run the `cmd/api` application.
- **db/psql**: Connect to the database using `psql`.
- **db/migrations/new name=$1**: Create a new database migration.
- **db/migrations/up**: Apply all up database migrations.
- **db/check**: Check the database connection and print the current DSN.
- **audit**: Tidy dependencies, format, vet, and test all code.
- **vendor**: Tidy, verify, and vendor dependencies.
- **build/api**: Build the `cmd/api` application.

To see the available commands, run:
```sh
make help
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---