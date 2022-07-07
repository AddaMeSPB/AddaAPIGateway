//
//  Environment+App.swift
//  
//
//  Created by Alif on 3/8/20.
//

import Vapor

extension Environment {
    // HOSTS
    static let eventHost = Self.get("EVENTS_URL")
    static let userHost = Self.get("USERS_URL")
    public static var staging: Environment { .init(name: "staging") }
}
