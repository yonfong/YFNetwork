//
//  Networkable.swift
//  Networkable
//
//  Created by sky on 2022/1/4.
//

import Moya

public typealias CompletionHandler<T> = ((Result<T, APIError>) -> Void)

public protocol Networkable {
    associatedtype Target: TargetType

    static var provider: MoyaProvider<Target> { get }
}

extension Networkable {
    public static var provider: MoyaProvider<Target> {
        get { MoyaProvider<Target>() }
    }
}

public extension TargetType where Self: Networkable {
    @discardableResult
    func request() -> Cancellable {
        return Self.provider.request(self as! Self.Target) { result in
            debugPrint("request Finished")
        }
    }
    
    @discardableResult
    func request<T:Decodable>(modeType:T.Type, completionHandler: CompletionHandler<T>? = nil) -> Cancellable {
        return Self.provider.request((self as! Self.Target), modeType: modeType, completionHandler: completionHandler)
    }
}



