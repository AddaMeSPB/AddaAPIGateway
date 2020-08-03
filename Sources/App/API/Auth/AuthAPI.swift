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
