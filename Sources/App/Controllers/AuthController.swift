//
//  AuthController.swift
//  
//
//  Created by Alif on 3/8/20.
//

import Vapor

extension AuthController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let auth = routes.grouped("auth")
        auth.post("login", use: beginSMSVerification)
        auth.post("verify_sms", use: validateVerificationCode)
        auth.post("refreshToken", use: refreshAccessToken)
//        routes.get(":users_id", use: find)
//        routes.put(":users_id", use: update)
    }
}

final class AuthController {

    private func beginSMSVerification(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        return try req.auth.login(req).hop(to: req.eventLoop)
    }

    private func validateVerificationCode(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        return try req.auth.verifySMS(req).hop(to: req.eventLoop)
    }

    private func refreshAccessToken(_ req: Request)throws -> EventLoopFuture<ClientResponse>  {
        return try req.auth.refreshToken(req).hop(to: req.eventLoop)
    }
}
