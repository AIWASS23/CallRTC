//
//  SocketConfiguration.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

struct SocketConfiguration {
    private(set) var url: URL
    
    static func socketEndpoint() -> SocketConfiguration {
        let path = "/ws"
        
        return makeEndpoint(path: path)
    }
    
    private static func makeEndpoint(path: String) -> SocketConfiguration {
        let socketURL = NetworkConfig.socketURL
        
        guard let fullURL = URL(string: socketURL + path) else {
            preconditionFailure("Invalid URL for path: \(path)")
        }

        return SocketConfiguration(url: fullURL)
    }
}