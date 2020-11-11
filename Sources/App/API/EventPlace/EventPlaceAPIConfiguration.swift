//
//  File.swift
//  
//
//  Created by Saroar Khandoker on 20.09.2020.
//

import Vapor

public struct EventPlaceAPIConfiguration {
    public let baseURL: URI

    /// Initializer
    ///
    /// - Parameters:
    ///   - baseURL: ...
    public init(baseURL: String) {
        self.baseURL = URI(string: baseURL)
    }

    public static var environment: EventPlaceAPIConfiguration {
        guard
            let baseURL = Environment.get("EVENTS_URL")
            else {
            fatalError("Event EventPlace environmant variables not set")
        }
        return .init(baseURL: baseURL)
    }
}

extension Application {
    public var eventplaces: EventPlaceAPI { .init(self) }
}

extension Request {
    public var eventplaces: EventPlaceAPI { .init(application) }
}
