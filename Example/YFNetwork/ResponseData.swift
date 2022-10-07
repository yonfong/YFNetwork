//
//  ResponseData.swift
//  Networkable
//
//  Created by sky on 2022/1/4.
//

import Foundation
import YFNetwork

public struct ResponseData<T>: Codable where T: Codable {
    public var code: Int
    public var message: String?
    var data: T?
}

extension ResponseData: ResponseVerifiable {
    public var isValid: Bool {
        return code == 1
    }
}
