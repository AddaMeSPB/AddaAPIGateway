//
//  EventsController.swift
//  
//
//  Created by Alif on 3/8/20.
//

import Vapor

extension EventsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(use: create)
        routes.get(use: list)
        routes.get(":events_id", use: read)
        routes.put(use: update)
        routes.delete(":events_id", use: delete)
    }
}

final class EventsController {

    func create(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        if req.loggedIn == false {
            throw Abort(.unauthorized)
        }

        return try req.events.create(req).hop(to: req.eventLoop)
    }

    func read(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        if req.loggedIn == false {
            throw Abort(.unauthorized)
        }

        return try req.events.read(req).hop(to: req.eventLoop)
    }

    func list(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        if req.loggedIn == false {
            throw Abort(.unauthorized)
        }
        return try req.events.list(req).hop(to: req.eventLoop)
    }

    func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        if req.loggedIn == false {
            throw Abort(.unauthorized)
        }

        return try req.events.update(req).hop(to: req.eventLoop)
    }

    func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        if req.loggedIn == false {
            throw Abort(.unauthorized)
        }

        return try req.events.delete(req).hop(to: req.eventLoop)
    }

}

