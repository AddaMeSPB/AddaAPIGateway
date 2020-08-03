//
//  EventsAPIConfiguration.swift
//  
//
//  Created by Alif on 3/8/20.
//

import Vapor

public struct EventsAPIConfiguration {
    public let baseURL: URI

    /// Initializer
    ///
    /// - Parameters:
    ///   - baseURL: ...
    public init(baseURL: String) {
        self.baseURL = URI(string: baseURL)
    }

    public static var environment: EventsAPIConfiguration {
        guard
            let baseURL = Environment.get("EVENTS_URL")
            else {
            fatalError("Events environmant variables not set")
        }
        return .init(baseURL: baseURL)
    }
}

extension Application {
    public var events: EventsAPI { .init(self) }
}

extension Request {
    public var events: EventsAPI { .init(application) }
}
