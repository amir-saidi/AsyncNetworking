//
//  NetworkingModel.swift
//  
//
//  Created by Amir Saidi on 23.1.22.
//

import Foundation

public var BASE_URL = ""

public enum ApiEndpoint: String {
   case empty = ""
}

public enum ApiURL { case
    base(ApiEndpoint, _ params: String = ""),
    customBase(base: String, endpoint: ApiEndpoint, _ params: String = ""),
    custom(base: String, endpoint: String, _ params: String = "")
    
    var urlStr: String {
        switch self {
        case .base(let endPoint, let urlParams):
            return urlParams == "" ? "\(BASE_URL)\(endPoint.rawValue)" : "\(BASE_URL)\(endPoint.rawValue)?\(urlParams)"
        case .customBase(let base, let endpoint, let urlParams):
            return urlParams == "" ? "\(base)\(endpoint.rawValue)" : "\(base)\(endpoint.rawValue)?\(urlParams)"
        case .custom(let base, let endpoint, let urlParams):
            return urlParams == "" ? "\(base)\(endpoint)" : "\(base)\(endpoint)?\(urlParams)"
        }
    }
    
    var url: URL {
        return URL(string: urlStr)!
    }
}

public struct EmptyRequest: Codable {}
