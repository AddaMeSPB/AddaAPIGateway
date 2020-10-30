//
//  ChatsAPIConfiguration.swift
//  
//
//  Created by Saroar Khandoker on 28.10.2020.
//

import Vapor

public struct ChatsAPIConfiguration {
    public let baseURL: URI

    /// Initializer
    ///
    /// - Parameters:
    ///   - baseURL: ...
    public init(baseURL: String) {
        self.baseURL = URI(string: baseURL)
    }

    public static var environment: ChatsAPIConfiguration {
        guard
            let baseURL = Environment.get("CHATS_URL")
            else {
            fatalError("CHATS environmant variables not set")
        }
        return .init(baseURL: baseURL)
    }
}

extension Application {
    public var chats: ChatsAPI { .init(self) }
}

extension Request {
    public var chats: ChatsAPI { .init(application) }
}

