//
//  JWTMiddleware.swift
//  
//
//  Created by Alif on 3/8/20.
//

import Vapor
import JWT

public final class JWTMiddleware: Middleware {
    
    public init() {}

    public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {

        guard let token = request.headers.bearerAuthorization?.token.utf8 else {
            return request.eventLoop.makeFailedFuture(
                Abort(.unauthorized, reason: "Missing authorization bearer header")
            )
        }

        do {
            request.payload = try request.jwt.verify(Array(token), as: Payload.self)
        } catch let JWTError.claimVerificationFailure(name: name, reason: reason) {
            request.logger.error("JWT Verification Failure: \(name) \(reason)")
            return request.eventLoop.makeFailedFuture(JWTError.claimVerificationFailure(name: name, reason: reason))
        } catch let error {
            return request.eventLoop.makeFailedFuture(
                Abort(.unauthorized, reason: "You are not authorized this token \(error)")
            )
        }

        return next.respond(to: request)
    }
}

extension AnyHashable {
    static let payload: String = "jwt_payload"
}

extension Request {
    var loggedIn: Bool {
        return self.storage[PayloadKey.self] != nil ?  true : false
    }

    var payload: Payload {
        get { self.storage[PayloadKey.self]! } // should not use it
        set { self.storage[PayloadKey.self] = newValue }
    }
}

