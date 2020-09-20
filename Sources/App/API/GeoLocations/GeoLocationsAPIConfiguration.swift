//
//  File.swift
//  
//
//  Created by Saroar Khandoker on 20.09.2020.
//

import Vapor

public struct GeoLocationsAPIConfiguration {
    public let baseURL: URI

    /// Initializer
    ///
    /// - Parameters:
    ///   - baseURL: ...
    public init(baseURL: String) {
        self.baseURL = URI(string: baseURL)
    }

    public static var environment: GeoLocationsAPIConfiguration {
        guard
            let baseURL = Environment.get("EVENTS_URL")
            else {
            fatalError("Events GEO LOCATIONs environmant variables not set")
        }
        return .init(baseURL: baseURL)
    }
}

extension Application {
    public var geolocations: GeoLocationsAPI { .init(self) }
}

extension Request {
    public var geolocations: GeoLocationsAPI { .init(application) }
}
