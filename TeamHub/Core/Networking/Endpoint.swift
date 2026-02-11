//
//  Endpoint.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String] { get }
}

extension Endpoint {
    var method: String { "GET" }
    var headers: [String: String] { ["Content-Type": "application/json"] }
    
    func makeURL() throws -> URL {
        let full = baseURL + path
        guard let url = URL(string: full) else { throw AppError.invalidURL }
        return url
    }
}
