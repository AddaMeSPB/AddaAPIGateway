//
//  EventPlaceAPI.swift
//  
//
//  Created by Saroar Khandoker on 20.09.2020.
//

import Vapor

public struct EventPlaceAPI {
    let application: Application
    
    init(_ app: Application) {
        application = app
    }
}

// MARK: - Configuration

extension EventPlaceAPI {
    struct ConfigurationKey: StorageKey {
        typealias Value = EventPlaceAPIConfiguration
    }

    public var configuration: EventPlaceAPIConfiguration? {
        get {
            application.storage[ConfigurationKey.self]
        }
        nonmutating set {
            application.storage[ConfigurationKey.self] = newValue
        }
    }
}

extension EventPlaceAPI {
    /// Returns a list of events
    func list(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        guard let configuration = self.configuration else {
            fatalError("EventsAPI not configured. Use app.events.configuration = ...")
        }
        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }

        var uri = configuration.baseURL
        uri.path += "/eventplaces"
        return application.client.get(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ])
    }

    func read(_ req: Request) throws -> EventLoopFuture<ClientResponse> {

        guard let configuration = self.configuration else {
            fatalError("EventPlaceAPI not configured. Use app.events.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }

        var uri = configuration.baseURL
        guard let id = req.parameters.get("eventplacesId") else {
            throw Abort(.badRequest, reason: "param id is missing")
        }
        uri.path += "/eventplaces/\(id)"
        return application.client.get(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ])
    }

    func create(_ req: Request) throws -> EventLoopFuture<ClientResponse> {

        guard let configuration = self.configuration else {
            fatalError("EventPlace not configured. Use app.events.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }

        var uri = configuration.baseURL
        uri.path += "/eventplaces"

        return application.client.post(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ], beforeSend: { outGoingReq in
            outGoingReq.body = req.body.data
        })

    }

    func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {

        guard let configuration = self.configuration else {
            fatalError("EventPlaceAPI not configured. Use app.events.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "Missing Authorization token")
        }

        var uri = configuration.baseURL
//        guard let id = req.parameters.get("events_id") else {
//            throw Abort(.badRequest, reason: "param id is missing")
//        }
        uri.path += "/eventplaces"

        return application.client.put(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ], beforeSend: { outGoingReq in
            outGoingReq.body = req.body.data
        })
    }

    func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        guard let configuration = self.configuration else {
            fatalError("EventPlaceAPI not configured. Use app.events.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }

        var uri = configuration.baseURL
        guard let id = req.parameters.get("events_id") else {
            throw Abort(.badRequest, reason: "param id is missing")
        }
        uri.path += "/eventplaces/\(id)"

        return application.client.delete(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ])
    }
}
