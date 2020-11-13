//
//  RoutesBuilder+Extension.swift
//  
//
//  Created by Saroar Khandoker on 13.11.2020.
//

import Vapor

extension RoutesBuilder {
    @discardableResult
    public func postBigFile<Response>(
        _ path: PathComponent...,
        use closure: @escaping (Request) throws -> Response
    ) -> Route
        where Response: ResponseEncodable
    {
        return self.on(.POST, path, body: .collect(maxSize: 50_000_000), use: closure)
    }

    @discardableResult
    public func postBigFile<Response>(
        _ path: [PathComponent],
        use closure: @escaping (Request) throws -> Response
    ) -> Route
        where Response: ResponseEncodable
    {
        return self.on(.POST, path, body: .collect(maxSize: 50_000_000), use: closure)
    }

    @discardableResult
    public func putBigFile<Response>(
        _ path: PathComponent...,
        use closure: @escaping (Request) throws -> Response
    ) -> Route
        where Response: ResponseEncodable
    {
        return self.on(.PUT, path, body: .collect(maxSize: 10_000_000), use: closure)
    }

    @discardableResult
    public func putBigFile<Response>(
        _ path: [PathComponent],
        use closure: @escaping (Request) throws -> Response
    ) -> Route
        where Response: ResponseEncodable
    {
        return self.on(.PUT, path, body: .collect(maxSize: 10_000_000), use: closure)
    }
}
