//
//  HeadersAndMethodsModel.swift
//  
//
//  Created by Amir Saidi on 23.1.22.
//

import Foundation

public enum ContentType: String { case
    none = "none",
    formdata = "form-data",
    appJson = "application/json",
    xwwwFormUrlEncoded = "application/x-www-form-urlencoded",
    raw = "raw",
    binary = "binary"
}

public enum HeaderField { case
    contentType(ContentType),
    accept(ContentType),
    session(String),
    custom(String, String)
    
    var field: String {
        switch self {
        case .contentType(_):
            return "Content-Type"
        case .accept(_):
            return "Accept"
        case .session(_):
            return "SessionGuid"
        case .custom(let val, _):
            return val
        }
    }
    
    var content: String {
        switch self {
        case .contentType(let type), .accept(let type):
            return type.rawValue
        case .session(let guid):
            return guid
        case .custom(_, let val):
            return val
        }
    }
}

// MARK: - Http Methods

public enum HttpMethods: String {
    case GET, POST, PUT, PATCH, DELETE
}
