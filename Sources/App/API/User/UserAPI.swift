//
//  UserAPI.swift
//  
//
//  Created by Saroar Khandoker on 28.10.2020.
//

import Vapor

public struct UserAPI {
    let application: Application

    public init (_ app: Application) {
        application = app
    }
}

// MARK: - Configuration

extension UserAPI {
    struct ConfigurationKey: StorageKey {
        typealias Value = UserAPIConfiguration
    }

    public var configuration: UserAPIConfiguration? {
        get {
            application.storage[ConfigurationKey.self]
        }
        nonmutating set {
            application.storage[ConfigurationKey.self] = newValue
        }
    }
}

extension UserAPI {
    func find(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        guard let configuration = self.configuration else {
            fatalError("UsersAPI not configured. Use app.users.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }
        
        var uri = configuration.baseURL
        
        guard let usersID = req.parameters.get("usersId") else {
            throw Abort(.badRequest, reason: "\(#line) find usersID param is missing")
        }
        
        uri.path += "/users/\(usersID)"
        return application.client.get(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ])
    }

    func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {

        guard let configuration = self.configuration else {
            fatalError("\(#line) UsersAPI not configured. Use app.users.configuration = ...")
        }

        guard let token = req.headers[.authorization].first else {
            throw Abort(.badRequest, reason: "No token")
        }
        
        var uri = configuration.baseURL
        guard let usersID = req.parameters.get("usersID") else {
            throw Abort(.badRequest, reason: "\(#line) update param id is missing")
        }
        
        uri.path += "/users/\(usersID)"
        
        return application.client.get(uri, headers: [
            "Content-Type":"application/json",
            "authorization": token
        ])
    }

    
}
