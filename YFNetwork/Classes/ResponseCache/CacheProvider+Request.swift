//
//  CacheProvider+Request.swift
//  Networkable
//
//  Created by sky on 2022/1/5.
//

import Moya
import MoyaCache

public extension CacheProvider {
    @discardableResult
    func request(_ target: Provider.Target) -> Cancellable {
        return request(target) { result in
            debugPrint("request Finished")
        }
    }
    
    @discardableResult
    func request<T:Decodable>(_ target: Provider.Target, modeType:T.Type, completionHandler: CompletionHandler<T>? = nil) -> Cancellable {
        if completionHandler == nil {
            return request(target)
        }
        
        return request(target) { (result) in
            switch result{
            case let .success(response):
                do {
                    let mapedResponse = try response.map(T.self)
                    
                    if let verifyResponse = mapedResponse as? ResponseVerifiable, !verifyResponse.isValid {
                        completionHandler?(.failure(.verifyError(code: verifyResponse.code, message: verifyResponse.message)))
                    } else {
                        completionHandler?(.success(mapedResponse))
                    }
                } catch _ {
                    completionHandler?(.failure(.parseError))
                }
            case let .failure(error):
                completionHandler?(.failure(.moyaError(error)))
            }
        }
    }
}
