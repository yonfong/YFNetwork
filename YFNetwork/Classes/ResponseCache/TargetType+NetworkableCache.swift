//
//  TargetType+NetworkableCache.swift
//  Networkable
//
//  Created by sky on 2022/1/5.
//

import Moya
import MoyaCache

public extension TargetType where Self: Networkable, Self.Target.ResponseType == Moya.Response, Self.Target: Cacheable {
    static var cacheProvider: CacheProvider<MoyaProvider<Self.Target>> {
        return provider.cache
    }
}
