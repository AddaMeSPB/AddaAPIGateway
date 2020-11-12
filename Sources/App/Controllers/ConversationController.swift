//
//  ConversationController.swift
//  
//
//  Created by Saroar Khandoker on 28.10.2020.
//

import Vapor

extension ConversationController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.post(use: create)
    routes.post(":conversationsId", "users", ":usersId", use: addUserToConversation)
    routes.get(use: readAll) // "users", ":users_id",
    routes.get(":conversationsId", "messages", use: readAllMessageByCoversationID)
    routes.put(use: update)
    routes.delete(":conversationsId", use: delete)
  }
}

final class ConversationController {
  
  func create(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    if req.loggedIn == false { throw Abort(.unauthorized) }
    return try req.chats.createConversation(req).hop(to: req.eventLoop)
  }
  
  func readAll(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    
    if req.loggedIn == false { throw Abort(.unauthorized) }
    
    return try req.chats.readAllConversations(req).hop(to: req.eventLoop)
  }
  
  private func readAllMessageByCoversationID(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    
    if req.loggedIn == false { throw Abort(.unauthorized) }
    
    return try req.chats.readAllMessageByCoversationID(req).hop(to: req.eventLoop)
    
  }
  
  func addUserToConversation(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    return try req.chats.addUserToConversation(req).hop(to: req.eventLoop)
  }
  
  private func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    if req.loggedIn == false {
      throw Abort(.unauthorized)
    }
    
    return try req.chats.updateConversations(req).hop(to: req.eventLoop)
  }
  
  private func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    if req.loggedIn == false { throw Abort(.unauthorized) }
    
    return try req.chats.deleteConversation(req).hop(to: req.eventLoop)
    
  }
  
}


