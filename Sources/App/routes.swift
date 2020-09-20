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

//        let users = api.grouped("users")
//        let usersAuth = users.grouped(JWTMiddleware())
//        try usersAuth.register(collection: UserController() )

        let events = api.grouped("events")
        let eventsAuth = events.grouped(JWTMiddleware())
        try eventsAuth.register(collection: EventsController() )
        
        let geolocations = api.grouped("geo_locations")
        let geolocationsAuth = geolocations.grouped(JWTMiddleware())
        try geolocationsAuth.register(collection: GeoLocationController() )
    }
}
