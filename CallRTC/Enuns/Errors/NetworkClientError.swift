//
//  NetworkClientError.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation


enum NetworkClientError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case serverError(statusCode: Int, data: Data?)
    case noData
    case unauthorized
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL was invalid."
        case .requestFailed(let error):
            return "The request failed with error: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .serverError(let code, _):
            return "Server returned error with status code \(code)."
        case .noData:
            return "No data was returned from the server."
        case .unauthorized:
            return "User is unauthorized."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
