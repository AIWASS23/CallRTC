//
//  NetworkConfig.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


// import Foundation

//enum NetworkConfig {
//    static var baseURL: String {
//        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
//            fatalError("❌ BASE_URL not set in Info.plist")
//        }
//        
//        return baseURL
//    }
//    
//    static var socketURL: String {
//        guard let socketURL = Bundle.main.infoDictionary?["SOCKET_URL"] as? String else {
//            fatalError("❌ SOCKET_URL not set in Info.plist")
//        }
//        
//        return socketURL
//    }
//}


import Foundation

enum NetworkConfig {
    static let baseURL: String = "https://api.seuservidor.com"
    static let socketURL: String = "ws://localhost:8080"
}
