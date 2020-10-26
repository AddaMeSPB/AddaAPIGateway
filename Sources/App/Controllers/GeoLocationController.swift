//
//  GeoLocationsController.swift
//  
//
//  Created by Saroar Khandoker on 20.09.2020.
//

import Vapor

extension GeoLocationController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post(use: create)
        routes.get(use: list)
        routes.get(":geolocationsId", use: read)
        routes.put(use: update)
        routes.delete(":geolocationsId", use: delete)
    }
}

final class GeoLocationController {
   
        func create(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }

            return try req.geolocations.create(req).hop(to: req.eventLoop)
        }

        func read(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }

            return try req.geolocations.read(req).hop(to: req.eventLoop)
        }

        func list(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }
            return try req.geolocations.list(req).hop(to: req.eventLoop)
        }

        func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }

            return try req.geolocations.update(req).hop(to: req.eventLoop)
        }

        func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
            if req.loggedIn == false {
                throw Abort(.unauthorized)
            }

            return try req.geolocations.delete(req).hop(to: req.eventLoop)
        }
}
