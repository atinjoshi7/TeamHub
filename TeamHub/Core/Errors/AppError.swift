//
//  AppError.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

enum AppError: Error, LocalizedError, Equatable {
    
    case invalidURL
    case invalidResponse
    case decodingFailed
    case noInternet
    case server(String)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .decodingFailed:
            return "Failed to decode data."
        case .noInternet:
            return "No internet connection."
        case .server(let message):
            return message
        case .unknown:
            return "Something went wrong."
        }
    }
}
