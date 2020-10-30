//
//  File.swift
//  
//
//  Created by Saroar Khandoker on 01.10.2020.
//

import Vapor

public struct UserAPIConfiguration {
    public let baseURL: URI

    /// Initializer
    ///
    /// - Parameters:
    ///   - baseURL: ...
    public init(baseURL: String) {
        self.baseURL = URI(string: baseURL)
    }

    public static var environment: UserAPIConfiguration {
        guard
            let baseURL = Environment.get("AUTH_URL")
            else {
            fatalError("Auth environmant variables not set")
        }
        return .init(baseURL: baseURL)
    }
}

extension Application {
    public var users: UserAPI { .init(self) }
}

extension Request {
    public var users: UserAPI { .init(application) }
}

