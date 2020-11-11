//
//  EventPlaceController.swift
//  
//
//  Created by Saroar Khandoker on 20.09.2020.
//

import Vapor

extension EventPlaceController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(use: create)
        routes.get(use: list)
        routes.get(":eventplacesId", use: read)
        routes.put(use: update)
        routes.delete(":eventplacesId", use: delete)
    }
}

final class EventPlaceController {
   
        func create(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }

            return try req.eventplaces.create(req).hop(to: req.eventLoop)
        }

        func read(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }

            return try req.eventplaces.read(req).hop(to: req.eventLoop)
        }

        func list(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }
            return try req.eventplaces.list(req).hop(to: req.eventLoop)
        }

        func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }

            return try req.eventplaces.update(req).hop(to: req.eventLoop)
        }

        func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }

            return try req.eventplaces.delete(req).hop(to: req.eventLoop)
        }
}
