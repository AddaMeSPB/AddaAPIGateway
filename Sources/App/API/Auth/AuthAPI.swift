//
//  Auth.swift
//  
//
//  Created by Alif on 3/8/20.
//

import Vapor

public struct AuthAPI {
    let application: Application

    public init (_ app: Application) {
        application = app
    }
}

// MARK: - Configuration

extension AuthAPI {
    struct ConfigurationKey: StorageKey {
        typealias Value = AuthAPIConfiguration
    }

    public var configuration: AuthAPIConfiguration? {
        get {
            application.storage[ConfigurationKey.self]
        }
        nonmutating set {
            application.storage[ConfigurationKey.self] = newValue
        }
    }
}

extension AuthAPI {
    func login(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        guard let configuration = self.configuration else {
            fatalError("EventsAPI not configured. Use app.events.configuration = ...")
        }

        var uri = configuration.baseURL
        uri.path += "/auth/login"
        return application.client.post(uri, headers: [
            "Content-Type":"application/json"
        ], beforeSend: { outGoingReq in
            outGoingReq.body = req.body.data
        })
    }

    func verifySMS(_ req: Request) throws -> EventLoopFuture<ClientResponse> {

        guard let configuration = self.configuration else {
            fatalError("EventsAPI not configured. Use app.events.configuration = ...")
        }

        var uri = configuration.baseURL

        uri.path += "/auth/verify_sms"
        return application.client.post(uri, headers: [
            "Content-Type":"application/json"
        ], beforeSend: { outGoingReq in
            outGoingReq.body = req.body.data
        })
    }

    func refreshToken(_ req: Request) throws -> EventLoopFuture<ClientResponse> {

        guard let configuration = self.configuration else {
            fatalError("EventsAPI not configured. Use app.events.configuration = ...")
        }

        var uri = configuration.baseURL
        uri.path += "/auth/refreshToken"

        return application.client.post(uri, headers: [
            "Content-Type":"application/json"
        ], beforeSend: { outGoingReq in
            outGoingReq.body = req.body.data
        })

    }
  
  

//    func update(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
//
//        guard let configuration = self.configuration else {
//            fatalError("EventsAPI not configured. Use app.events.configuration = ...")
//        }
//
//        guard let token = req.headers[.authorization].first else {
//            throw Abort(.badRequest, reason: "No token")
//        }
//
//        var uri = configuration.baseURL
//        guard let id = req.parameters.get("events_id") else {
//            throw Abort(.badRequest, reason: "param id is missing")
//        }
//        uri.path += "/events/\(id)"
//
//        return application.client.put(uri, headers: [
//            "Content-Type":"application/json",
//            "authorization": token
//        ], beforeSend: { outGoingReq in
//            outGoingReq.body = req.body.data
//        })
//    }
//
//    func delete(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
//        guard let configuration = self.configuration else {
//            fatalError("EventsAPI not configured. Use app.events.configuration = ...")
//        }
//
//        guard let token = req.headers[.authorization].first else {
//            throw Abort(.badRequest, reason: "No token")
//        }
//
//        var uri = configuration.baseURL
//        guard let id = req.parameters.get("events_id") else {
//            throw Abort(.badRequest, reason: "param id is missing")
//        }
//        uri.path += "/events/\(id)"
//
//        return application.client.delete(uri, headers: [
//            "Content-Type":"application/json",
//            "authorization": token
//        ])
//    }
}
