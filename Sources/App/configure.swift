import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    guard let jwksString = Environment.process.JWKS else {
        fatalError("No value was found at the given public key environment 'JWKS'")
    }
    try app.jwt.signers.use(jwksJSON: jwksString)

    app.auth.configuration = .environment
    app.events.configuration = .environment

    // Encoder & Decoder
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    ContentConfiguration.global.use(encoder: encoder, for: .json)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    ContentConfiguration.global.use(decoder: decoder, for: .json)

    switch app.environment {
    case .production:
        app.http.server.configuration.hostname = "https://addame.com"
    case .development:
        app.http.server.configuration.port = 8080
        app.http.server.configuration.hostname = "0.0.0.0"
    default:
        app.http.server.configuration.port = 8080
        app.http.server.configuration.hostname = "0.0.0.0"
    }

    // register routes
    try routes(app)
}
