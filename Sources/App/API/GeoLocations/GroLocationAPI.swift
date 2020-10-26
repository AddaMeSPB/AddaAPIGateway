//
//  GeoLocationsAPI.swift
//  
//
//  Created by Saroar Khandoker on 20.09.2020.
//

import Vapor

public struct GeoLocationsAPI {
    let application: Application
    
    init(_ app: Application) {
        application = app
    }
}

// MARK: - Configuration

extension GeoLocationsAPI {
    struct ConfigurationKey: StorageKey {
        typealias Value = GeoLocationsAPIConfiguration
    }

    public var configuration: GeoLocationsAPIConfiguration? {
        get {
            application.storage[ConfigurationKey.self]
        }
        nonmutating set {
            application.storage[ConfigurationKey.self] = newValue
        }
    }
}

extension GeoLocationsAPI {
    /// Returns a list of events
    func list(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        guard let configuration = self.configuration else {
            fatalError("EventsAPI not configured. Use app.events.configuration = ...")
        }
        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }

        var uri = configuration.baseURL
        uri.path += "/geolocations"
        return application.client.get(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ])
    }

    func read(_ req: Request) throws -> EventLoopFuture<ClientResponse> {

        guard let configuration = self.configuration else {
            fatalError("GeoLocationsAPI not configured. Use app.events.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }

        var uri = configuration.baseURL
        guard let id = req.parameters.get("geolocationsId") else {
            throw Abort(.badRequest, reason: "param id is missing")
        }
        uri.path += "/geolocations/\(id)"
        return application.client.get(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ])
    }

    func create(_ req: Request) throws -> EventLoopFuture<ClientResponse> {

        guard let configuration = self.configuration else {
            fatalError("GeoLocationsAPI not configured. Use app.events.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }

        var uri = configuration.baseURL
        uri.path += "/geolocations"

        return application.client.post(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ], beforeSend: { outGoingReq in
            outGoingReq.body = req.body.data
        })

    }

    func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {

        guard let configuration = self.configuration else {
            fatalError("GeoLocationsAPI not configured. Use app.events.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "Missing Authorization token")
        }

        var uri = configuration.baseURL
//        guard let id = req.parameters.get("events_id") else {
//            throw Abort(.badRequest, reason: "param id is missing")
//        }
        uri.path += "/geolocations"

        return application.client.put(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ], beforeSend: { outGoingReq in
            outGoingReq.body = req.body.data
        })
    }

    func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        guard let configuration = self.configuration else {
            fatalError("GeoLocationsAPI not configured. Use app.events.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }

        var uri = configuration.baseURL
        guard let id = req.parameters.get("events_id") else {
            throw Abort(.badRequest, reason: "param id is missing")
        }
        uri.path += "/geolocations/\(id)"

        return application.client.delete(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ])
    }
}
