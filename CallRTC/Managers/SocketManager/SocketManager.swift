//
//  SocketManager.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation
import Combine

protocol SocketManager {
    var isConnected: Bool { get }
    var messagePublisher: AnyPublisher<SocketMessage<AnyCodable>, Never> { get }
        
    func connect() async throws
    func disconnect()
    func send<T: Codable>(_ message: SocketMessage<T>) throws
        
}