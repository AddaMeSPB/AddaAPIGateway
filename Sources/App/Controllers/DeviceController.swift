//
//  DeviceController.swift
//  
//
//  Created by Saroar Khandoker on 29.11.2020.
//

import Vapor

extension DeviceController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.post(use: createOrUpdate)
  }
}

final class DeviceController {
  private func createOrUpdate(_ req: Request) throws -> EventLoopFuture<ClientResponse>{
    if req.loggedIn == false { throw Abort(.unauthorized) }
    
    return try req.users.deviceCreateOrUpdate(req).hop(to: req.eventLoop)
    
  }
}
