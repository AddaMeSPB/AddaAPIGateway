//
//  ChatsAPI.swift
//  
//
//  Created by Saroar Khandoker on 28.10.2020.
//

import Vapor

public struct ChatsAPI {
  let application: Application
  
  public init (_ app: Application) {
    application = app
  }
}

// MARK: - Configuration

extension ChatsAPI {
  struct ConfigurationKey: StorageKey {
    typealias Value = ChatsAPIConfiguration
  }
  
  public var configuration: ChatsAPIConfiguration? {
    get {
      application.storage[ConfigurationKey.self]
    }
    nonmutating set {
      application.storage[ConfigurationKey.self] = newValue
    }
  }
}

// MARK: Send message

extension ChatsAPI {
  // WebSokcet request
  func chat(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    uri.path = "\(req.url)"
    return application.client.get(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ])
    
  }
  
  // For Message controller
  func createConversation(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    uri.path += "\(req.url)"
    
    return application.client.post(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ], beforeSend: { outGoingReq in
      outGoingReq.body = req.body.data
    })
    
  }
  
  func readAllMessagesByConversationID(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    
    guard let _ = req.parameters.get("conversationsId") else {
      throw Abort(.badRequest, reason: "param id is missing")
    }
    
    uri.path += "\(req.url)"
    return application.client.get(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ])
  }

  func readAllConversations(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    uri.path += "\(req.url)"
    return application.client.get(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ])
  }
  
  func read(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    guard let _ = req.parameters.get("conversationsId") else {
      throw Abort(.badRequest, reason: "param id is missing")
    }
    
    uri.path += "\(req.url)"

    return application.client.get(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ])
  }
  
  func readAllMessageByCoversationID(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    guard let conversationsId = req.parameters.get("conversationsId") else {
      throw Abort(.badRequest, reason: "param id is missing")
    }
    
    uri.path += "\(req.url)"
    return application.client.get(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ])
  }
  
  func addUserToConversation(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "Missing Authorization token")
    }
    
    var uri = configuration.baseURL
    
    guard let _ = req.parameters.get("conversationsId"),
          let _ = req.parameters.get("usersId") else {
      throw Abort(.badRequest, reason: "param conversationsId/usersId is missing")
    }
    
    uri.path += "\(req.url)"
    
    return application.client.post(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ], beforeSend: { outGoingReq in
      outGoingReq.body = req.body.data
    })
  }
  
  func updateMessage(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    uri.path += "/messages"
    return application.client.put(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ])
  }
  
  func updateConversations(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    uri.path += "/conversations"
    return application.client.put(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ])
  }
  
  func deleteConversation(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    guard let conversationsId = req.parameters.get("conversationsId") else {
      throw Abort(.badRequest, reason: "param id is missing")
    }
    uri.path += "/conversations/\(conversationsId)"
    
    return application.client.delete(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ])
  }
  
  func deleteMessage(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    guard let configuration = self.configuration else {
      fatalError("ChatsAPI not configured. Use app.chats.configuration = ...")
    }
    
    guard let token = req.headers[.authorization].first else {
      throw Abort(.badRequest, reason: "No token")
    }
    
    var uri = configuration.baseURL
    guard let messagesId = req.parameters.get("messagesId") else {
      throw Abort(.badRequest, reason: "param id is missing")
    }
    uri.path += "/messages/\(messagesId)"
    
    return application.client.delete(uri, headers: [
      "Content-Type":"application/json",
      "authorization": token
    ])
  }
}


