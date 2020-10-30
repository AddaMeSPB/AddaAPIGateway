import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "AddaAPIGateway works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    try app.group("v1") { api in
        try api.register(collection: AuthController())

        let users = api.grouped("users")
        let usersAuth = users.grouped(JWTMiddleware())
        try usersAuth.register(collection: UsersController() )

        // EVENTS
        let events = api.grouped("events")
        let eventsAuth = events.grouped(JWTMiddleware())
        try eventsAuth.register(collection: EventsController() )
        
        // GEOLOCATION
        let geolocations = api.grouped("geolocations")
        let geolocationsAuth = geolocations.grouped(JWTMiddleware())
        try geolocationsAuth.register(collection: GeoLocationController() )
        
        // MESSAGES
        let messages = api.grouped("messages")
        let messagesAuth = messages.grouped(JWTMiddleware())
        try messagesAuth.register(collection: MessageController() )
        
        // CONVERSATIONS
        let conversations = api.grouped("conversations")
        let conversationsAuth = conversations.grouped(JWTMiddleware())
        try conversationsAuth.register(collection: ConversationController())
        
        // WEBSOCKET
        let chat = api.grouped("chat")
        let chatAuth = chat.grouped(JWTMiddleware())
        try chatAuth.register(collection: ChatController())
    }
}
