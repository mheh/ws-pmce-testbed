import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    app.commands.use(PMCECommand(),
                     as: "pmce")
    try routes(app)
}
