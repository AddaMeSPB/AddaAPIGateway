//
//  AuthAPIConfiguration.swift
//  
//
//  Created by Alif on 3/8/20.
//

import Vapor

public struct AuthAPIConfiguration {
    public let baseURL: URI

    /// Initializer
    ///
    /// - Parameters:
    ///   - baseURL: ...
    public init(baseURL: String) {
        self.baseURL = URI(string: baseURL)
    }

    public static var environment: AuthAPIConfiguration {
        guard
            let baseURL = Environment.get("AUTH_URL")
            else {
            fatalError("Auth environmant variables not set")
        }
        return .init(baseURL: baseURL)
    }
}

extension Application {
    public var auth: AuthAPI { .init(self) }
}

extension Request {
    public var auth: AuthAPI { .init(application) }
}

