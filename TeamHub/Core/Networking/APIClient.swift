//
//  APIClient.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

protocol APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
