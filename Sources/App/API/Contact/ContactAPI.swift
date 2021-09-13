//
//  File.swift
//  
//
//  Created by Saroar Khandoker on 13.11.2020.
//

import Vapor

public class ContactAPI {
  let application: Application

  public init (_ app: Application) {
    application = app
  }
}

// MARK: - Configuration

extension ContactAPI {
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
    public var contacts: ContactAPI { .init(self) }
}

extension Request {
    public var contacts: ContactAPI { .init(application) }
}

extension ContactAPI {
  func create(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
    guard let configuration = self.configuration else {
      fatalError("UsersAPI(ContactAPI) not configured. Use app.users.configuration = ...")
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
}
