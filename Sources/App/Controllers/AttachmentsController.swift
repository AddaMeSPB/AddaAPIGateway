//
//  AttachmentsController.swift
//  
//
//  Created by Saroar Khandoker on 19.11.2020.
//

import Vapor

extension AttachmentController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.post(use: create)
    routes.delete(use: delete)
  }
}

final class AttachmentController {
  func create(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    if req.loggedIn == false { throw Abort(.unauthorized) }
    
    return try req.attachments.create(req).hop(to: req.eventLoop)
  }
  
  private func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
      if req.loggedIn == false { throw Abort(.unauthorized) }

    return try req.attachments.delete(req).hop(to: req.eventLoop)
  }
}
