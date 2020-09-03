//
//  Payload.swift
//  
//
//  Created by Alif on 3/8/20.
//

import Vapor
import JWT
import JWTKit
import MongoKitten

struct PayloadKey: StorageKey {
    typealias Value = Payload
}

struct Payload: JWTPayload {
    let firstname: String?
    let lastname: String?
    let phoneNumber: String
    let userId: ObjectId
    var status: Int = 0
    let exp: Int
    let iat: Int

    init(id: ObjectId, phoneNumber: String) {
        self.userId = id
        self.phoneNumber = phoneNumber
        self.firstname = nil
        self.lastname = nil
        self.exp = Int( Date(timeIntervalSinceNow: 60*60*24*40).timeIntervalSince1970 ) // week
        self.iat = Int( Date().timeIntervalSince1970 )
    }

   func verify(using signer: JWTSigner) throws {
        let expiration = Date(timeIntervalSince1970: Double(self.exp))
        try ExpirationClaim(value: expiration).verifyNotExpired()
    }
}

