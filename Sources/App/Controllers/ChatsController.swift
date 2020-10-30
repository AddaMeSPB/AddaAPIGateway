//
//  ChatController.swift
//  
//
//  Created by Saroar Khandoker on 28.10.2020.
//

import Vapor

extension ChatController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        // routes.webSocket(onUpgrade: self.webSocket)
        routes.get(use: self.chat)
    }
}

struct ChatController {
//    func webSocket(_ req: Request, socket: WebSocket) throws -> EventLoopFuture<ClientResponse> {
//        if req.loggedIn == false { throw Abort(.unauthorized) }
//        return try req.chats.chat(req)
//    }
    
    func chat(_ req: Request) throws -> EventLoopFuture<ClientResponse> { // this is wrong have to websocket client
        if req.loggedIn == false { throw Abort(.unauthorized) }
        return try req.chats.chat(req)
    }
}
    

    
