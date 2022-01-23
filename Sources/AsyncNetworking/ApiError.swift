//
//  ApiError.swift
//  
//
//  Created by Amir Saidi on 23.1.22.
//

import Foundation


public enum ApiError: Error {
    case server(String, Int)
    case badRequest(Data, Int)
    case badURL(String = "Given url is not in the correct format")
    case badInputData(String = "Bad Input Data")
    case parsing(String = "Failed to parse response. Please check response model formatting.")
    case badResponse(String = "Received bad response")
    case noData(String = "Didn't receive any data with response")
    
    
    var message: String {
        switch self {
        case .server(let message, let code):
            return "Error \(code): \(message)"
        case .badRequest(let data, let code):
            return "Error \(code): \(String(data: data, encoding: .utf8) ?? "")"
        case .badURL(let message):
            return message
        case .badInputData(let message):
            return message
        case .parsing(let message):
            return message
        case .badResponse(let message):
            return message
        case .noData(let message):
            return message
        }
    }
}
