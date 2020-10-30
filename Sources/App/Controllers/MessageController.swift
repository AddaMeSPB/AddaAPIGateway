//
//  MessageController.swift
//  
//
//  Created by Saroar Khandoker on 28.10.2020.
//

import Vapor

extension MessageController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get("by" ,"conversations" ,":conversationsId", use: readAllMessagesByConversationID)
        routes.put(use: update)
        routes.delete(":messagesId", use: delete)
    }
}

final class MessageController {
    private func readAllMessagesByConversationID(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        
        if req.loggedIn == false { throw Abort(.unauthorized) }
        
        return try req.chats.readAllMessagesByConversationID(req)
        
    }
    
    private func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        if req.loggedIn == false {
            throw Abort(.unauthorized)
        }

        return try req.chats.updateMessage(req)
    }

    private func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        if req.loggedIn == false { throw Abort(.unauthorized) }

        return try req.chats.deleteMessage(req)
        
    }
}


