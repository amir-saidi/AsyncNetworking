//
//  AsyncNetworking.swift
//
//
//  Created by Amir Saidi on 23.1.22.
//

import Foundation

@available(iOS 15.0.0, *)
public struct AsyncNetworking {
        
    public func get<R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:]) async throws -> R {
        try await request(apiUrl: apiUrl, method: .GET, body: EmptyRequest())
    }
    
    public func get<T:Codable, R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:], body: T) async throws -> R {
        try await request(apiUrl: apiUrl, method: .GET, body: body)
    }
    
    public func post<R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:]) async throws -> R {
        try await request(apiUrl: apiUrl, method: .POST, body: EmptyRequest())
    }
    
    public func post<T:Codable, R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:], body: T) async throws -> R {
        try await request(apiUrl: apiUrl, method: .POST, body: body)
    }
    
    public func put<R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:]) async throws -> R {
        try await request(apiUrl: apiUrl, method: .PUT, body: EmptyRequest())
    }
    
    public func put<T:Codable, R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:], body: T) async throws -> R {
        try await request(apiUrl: apiUrl, method: .PUT, body: body)
    }
    
    public func patch<R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:]) async throws -> R {
        try await request(apiUrl: apiUrl, method: .PATCH, body: EmptyRequest())
    }
    
    public func patch<T:Codable, R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:], body: T) async throws -> R {
        try await request(apiUrl: apiUrl, method: .PATCH, body: body)
    }
    
    public func delete<R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:]) async throws -> R {
        try await request(apiUrl: apiUrl, method: .DELETE, body: EmptyRequest())
    }
    
    public func delete<T:Codable, R: Codable>(apiUrl: ApiURL, headers: [String: String] = [:], body: T) async throws -> R {
        try await request(apiUrl: apiUrl, method: .DELETE, body: body)
    }
    
    
    private func request<T:Codable, R: Codable>(apiUrl: ApiURL, method: HttpMethods, headers: [String: String] = [:], body: T) async throws -> R {
        do {
            let request = try prepareRequest(apiUrl: apiUrl, headers: headers, method: method, body: body)
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let parsed = try? JSONDecoder().decode(R.self, from: data) else {
                throw ApiError.parsing()
            }
            return parsed
        } catch {
            throw error
        }
    }
    
    private func prepareRequest<T: Codable>(apiUrl: ApiURL, headers: [String: String] = [:], method: HttpMethods, body: T) throws -> URLRequest {
        
        var request = URLRequest(url: apiUrl.url)
        request.httpMethod = method.rawValue

        if T.self != EmptyRequest.self {
            let encoder = JSONEncoder()
            guard let reqData = try? encoder.encode(body) else {
                throw ApiError.badInputData()
            }
            request.httpBody = reqData
        }
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
}
