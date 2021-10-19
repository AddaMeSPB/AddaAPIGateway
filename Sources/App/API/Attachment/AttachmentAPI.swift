//
//  AttachmentAPI.swift
//  
//
//  Created by Saroar Khandoker on 19.11.2020.
//

import Vapor

public class AttachmentAPI {
  let application: Application

  public init (_ app: Application) {
    application = app
  }
}

// MARK: - Configuration

extension AttachmentAPI {
  struct ConfigurationKey: StorageKey {
    typealias Value = UserAPIConfiguration
  }

  public var configuration: UserAPIConfiguration? {
    get {
      application.storage[ConfigurationKey.self]
    }
    set {
      application.storage[ConfigurationKey.self] = newValue
    }
  }
}

extension Application {
    public var attachments: AttachmentAPI { .init(self) }
}

extension Request {
    public var attachments: AttachmentAPI { .init(application) }
}

extension AttachmentAPI {
  func create(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    guard let configuration = self.configuration else {
      fatalError("UsersAPI(AttachmentAPI) not configured. Use app.users.configuration = ...")
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
  
  func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
      guard let configuration = self.configuration else {
          fatalError("UsersAPI(AttachmentAPI) not configured. Use app.events.configuration = ...")
      }

      guard let token = req.headers[.authorization].first else {
          throw Abort(.badRequest, reason: "No token")
      }

      var uri = configuration.baseURL
      guard let id = req.parameters.get("attachmentsId") else {
          throw Abort(.badRequest, reason: "param id is missing")
      }
      uri.path += "\(req.url)"

      return application.client.delete(uri, headers: [
          "Content-Type":"application/json",
          "authorization": token
      ])
  }
}
