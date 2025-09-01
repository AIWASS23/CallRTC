//
//  DeviceTokenEndpoint.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation

struct DeviceTokenEndpoint: Endpoint {
    var url: URL
    var method: String
    var headers: [String: String]
    var body: Data?
    
    static func registerDeviceToken(_ dto: RegisterDeviceTokenDTO) -> UsersEndpoint {
        let path = "/device-token/register"
        
        return makeEndpoint(path: path, method: "POST", payload: dto)
    }
    
    private static func makeEndpoint(path: String, method: String, payload: RegisterDeviceTokenDTO) -> UsersEndpoint {
        let baseURL = NetworkConfig.baseURL
        guard let fullURL = URL(string: baseURL + path) else {
            preconditionFailure("Invalid URL for path: \(path)")
        }

        let body = try? JSONEncoder().encode(payload)

        return UsersEndpoint(
            url: fullURL,
            method: method,
            headers: ["Content-Type": "application/json"],
            body: body
        )
    }
}
