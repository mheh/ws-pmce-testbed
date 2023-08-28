import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    app.logger.info("command args: \(CommandLine.arguments)")
    app.commands.use(ServerCommand(),
                     as: "server",
                     isDefault: false)
    try routes(app)
}
