//
//  File.swift
//  
//
//  Created by Saroar Khandoker on 13.11.2020.
//

import Vapor

extension ContactsController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.postBigFile(use: create)
  }
}

class ContactsController {
  func create(_ req: Request) throws -> EventLoopFuture<ClientResponse>  {
    if req.loggedIn == false { throw Abort(.unauthorized) }
    return try req.contacts.create(req).hop(to: req.eventLoop)
  }
}
