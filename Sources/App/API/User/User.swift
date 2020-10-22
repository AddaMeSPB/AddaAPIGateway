//
//  File.swift
//  
//
//  Created by Saroar Khandoker on 01.10.2020.
//

import Vapor
import MongoKitten

struct User: Codable {
    var _id: ObjectId?
    var phoneNumber: String
    var firstName: String?
    var lastName: String?
    var email: String?
    var contactIds: [ObjectId]?
    var deviceIds: [ObjectId]?
    var createdAt: Date
    var updatedAt: Date
}
