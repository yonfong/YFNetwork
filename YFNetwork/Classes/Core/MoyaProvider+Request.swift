//
//  MoyaProvider+Request.swift
//  Networkable
//
//  Created by sky on 2022/1/4.
//

import Moya

public extension MoyaProvider {
    @discardableResult
    func request(_ target: Target) -> Cancellable {
        return request(target) { result in
            debugPrint("request Finished")
        }
    }
    
    @discardableResult
    func request<T:Decodable>(_ target: Target, modeType:T.Type, completionHandler: CompletionHandler<T>? = nil) -> Cancellable {
        if completionHandler == nil {
            return request(target)
        }
        
        return request(target) { (result) in
            switch result{
            case let .success(response):
                do {
                    let mapedResponse = try response.map(T.self)
                    if let verifyResponse = mapedResponse as? ResponseVerifiable, verifyResponse.isValid {
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
