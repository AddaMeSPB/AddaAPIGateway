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
    app.eventplaces.configuration = .environment
    app.chats.configuration = .environment
    app.users.configuration = .environment

    // Encoder & Decoder
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    ContentConfiguration.global.use(encoder: encoder, for: .json)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    ContentConfiguration.global.use(decoder: decoder, for: .json)

    switch app.environment {
    case .production:
        app.http.server.configuration.hostname = "0.0.0.0"
        app.http.server.configuration.port = 8080
    case .development:
        app.http.server.configuration.port = 8080
        app.http.server.configuration.hostname = "0.0.0.0"
    default:
        app.http.server.configuration.port = 8080
        app.http.server.configuration.hostname = "0.0.0.0"
    }
    
//    if app.environment == .production {
//        let homePath = app.directory.workingDirectory
//        let certPath = homePath + "cert/cert.pem"
//        let chainPath = homePath + "cert/chain.pem"
//        let keyPath = homePath + "cert/key.pem"
//        // 2
//        app.http.server.configuration.supportVersions = [.two]
//        // 3
//        try app.http.server.configuration.tlsConfiguration = .forServer(
//            certificateChain: [
//                .certificate(.init(file: certPath,
//                                   format: .pem)),
//                .certificate(.init(file: chainPath,
//                                   format: .pem))
//            ],
//            privateKey: .file(keyPath)
//        )
//    }
    // register routes
    try routes(app)
}
