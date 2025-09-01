//
//  DefaultAPNSClient.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation
import Combine

class DefaultAPNSClient: APNSClient {
    private let protectedNetworkClient: any ProtectedNetworkClient
    
    init(protectedNetworkClient: any ProtectedNetworkClient) {
        self.protectedNetworkClient = protectedNetworkClient
    }
    
    func registerAPNsDeviceToken(with request: RegisterDeviceTokenDTO) -> AnyPublisher<RegisterDeviceTokenResponse, NetworkClientError> {
        let endpoint = DeviceTokenEndpoint.registerDeviceToken(request)
        
        return protectedNetworkClient.request(endpoint: endpoint).eraseToAnyPublisher()
    }
    
    func registerVoIPDeviceToken(with request: RegisterDeviceTokenDTO) -> AnyPublisher<RegisterDeviceTokenResponse, NetworkClientError> {
        let endpoint = DeviceTokenEndpoint.registerDeviceToken(request)
        
        return protectedNetworkClient.request(endpoint: endpoint).eraseToAnyPublisher()
    }
}
