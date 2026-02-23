//
//  URLSessionAPIClient.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import Combine
final class URLSessionAPIClient: APIClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        
        let url = try endpoint.makeURL()
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let http = response as? HTTPURLResponse else {
                throw AppError.invalidResponse
            }
            
            guard (200...299).contains(http.statusCode) else {
                throw AppError.server("Server Error: \(http.statusCode)")
            }
            
            do {
                return try JSONDecoder.employeesDecoder.decode(T.self, from: data)
            } catch {
                throw AppError.decodingFailed
            }
            
        } catch {
            throw AppError.unknown
        }
    }
}

