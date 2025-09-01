//
//  CallEndpoint.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation

struct CallEndpoint: Endpoint {
    var url: URL
    var method: String
    var headers: [String : String]
    var body: Data?
    
    static func startCall(dto: StartCallRequest) -> CallEndpoint {
        let path = "/calls/create"
        
        return makeEndpoint(path: path, method: "POST", payload: dto)
    }
    
    private static func makeEndpoint<T: Encodable>(path: String, method: String, payload: T?) -> CallEndpoint {
        let baseURL = NetworkConfig.baseURL
        guard let fullURL = URL(string: baseURL + path) else {
            preconditionFailure("Invalid URL for path: \(path)")
        }

        let body = try? JSONEncoder().encode(payload)

        return CallEndpoint(
            url: fullURL,
            method: method,
            headers: ["Content-Type": "application/json"],
            body: body
        )
    }
}
