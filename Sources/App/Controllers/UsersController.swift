//
//  UserController.swift
//  
//
//  Created by Saroar Khandoker on 28.10.2020.
//

import Vapor

extension UsersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(":usersId", use: find)
        routes.put(use: update)
    }
}

final class UsersController {

    private func find(_ req: Request) throws -> EventLoopFuture<ClientResponse>  {
        if req.loggedIn == false { throw Abort(.unauthorized) }
        return try req.users.find(req).hop(to: req.eventLoop)
    }

    private func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        if req.loggedIn == false { throw Abort(.unauthorized) }
        return try req.users.update(req).hop(to: req.eventLoop)
    }

}
