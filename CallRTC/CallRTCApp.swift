//
//  CallRTCApp.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//

import SwiftUI
import PushKit

@main
struct CallRTCApp: App {
    var body: some Scene {
        
        let networkClient = DefaultNetworkClient()
        let keychainService = KeychainService()
        
        let tokenRefresher = DefaultTokenRefresher(
            networkClient: networkClient,
            keychainService: keychainService
        )
        
        
        let protectedNetworkClient = DefaultProtectedNetworkClient(
            networkClient: networkClient,
            tokenRefresher: tokenRefresher,
            keychainService: keychainService
        )
        
        let callClient = DefaultCallClient(protectedNetworkClient: protectedNetworkClient)
    
        
        let socketManager = DefaultSocketManager(
            configuration: SocketConfiguration.socketEndpoint(),
            tokenRefresher: tokenRefresher,
            keychainService: keychainService
        )
        
        let apnsClient = DefaultAPNSClient(protectedNetworkClient: protectedNetworkClient)
        let pushService = DefaultPushService(apnsClient: apnsClient, pushRegistry: PKPushRegistry(queue: .main))
        let callKitManager = DefaultCallKitManager()
        
        WindowGroup {
            let engine = DefaultCallEngine(
                callClient: callClient,
                socketManager: socketManager,
                pushService: pushService,
                callKitManager: callKitManager
            )
            
            let config = CallConfiguration(
                calleeId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440000")!,
                callType: .video
            )
            
            CallView(engine: engine, config: config)
        }
    }
}
