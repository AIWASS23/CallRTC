//
//  DefaultCallClient.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation
import Combine

class DefaultCallClient: CallClient {
    private let protectedNetworkClient: ProtectedNetworkClient
    
    init(protectedNetworkClient: ProtectedNetworkClient) {
        self.protectedNetworkClient = protectedNetworkClient
    }
    
    func startCall(dto: StartCallRequest) -> AnyPublisher<StartCallResponse, NetworkClientError> {
        let enpoint = CallEndpoint.startCall(dto: dto)
        
        return protectedNetworkClient.request(endpoint: enpoint).eraseToAnyPublisher()
    }
}
