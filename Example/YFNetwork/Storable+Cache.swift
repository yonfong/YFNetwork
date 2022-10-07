//
//  Storable+Cache.swift
//  Networkable_Example
//
//  Created by sky on 2022/1/5.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Cache
import Moya
import MoyaCache
import Storable

extension Storable where Self: TargetType {
    public var allowsStorage: (Response) -> Bool {
        return { _ in
            return true
        }
    }

    public func cachedResponse(for key: CachingKey) throws -> Response {
        return try Storage<String, Moya.Response>().object(forKey: key.stringValue)
    }

    public func storeCachedResponse(_ cachedResponse: Response, for key: CachingKey) throws {
        try Storage<String, Moya.Response>().setObject(cachedResponse, forKey: key.stringValue)
    }

    public func removeCachedResponse(for key: CachingKey) throws {
        try Storage<String, Moya.Response>().removeObject(forKey: key.stringValue)
    }

    public func removeAllCachedResponses() throws {
        try Storage<String, Moya.Response>().removeAll()
    }
}

private extension Storage where Value == Moya.Response {
    convenience init() throws {
        let transformer = Transformer(toData: { $0.data }, fromData: { Value(statusCode: 200, data: $0) })
        try self.init(diskConfig: DiskConfig(name: "org.cocoapods.demo.cache.response"),
                      memoryConfig: MemoryConfig(),
                      transformer: transformer)
    }
}



