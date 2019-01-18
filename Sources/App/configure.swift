import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentPostgreSQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a PostgreSQL database
    guard let databaseUrl = Environment.get("DATABASE_URL") else {
        fatalError("DATABASE_URL needed")
    }
    guard let pgConfig = PostgreSQLDatabaseConfig(url: databaseUrl, transport: .unverifiedTLS) else {
        fatalError("Invalid DATABASE_URL format")
    }
    let pg = PostgreSQLDatabase(config: pgConfig)

    // Register the configured PostgreSQL database to the database config.
    var databases = DatabasesConfig()
    databases.enableLogging(on: .psql)
    databases.add(database: pg, as: .psql)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: DeviceStatus.self, database: .psql)
    services.register(migrations)

}
