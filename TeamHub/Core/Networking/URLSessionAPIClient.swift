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
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        endpoint.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        do {
            let (data, response) = try await session.data(for: request)
            
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

private extension JSONDecoder {
    static var employeesDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.joiningDateFormatter)
        return decoder
    }
}

private extension DateFormatter {
    static let joiningDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
}
