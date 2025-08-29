//
//  TokenRefresher.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation
import Combine

protocol TokenRefresher {
    func refreshTokenIfNeeded() -> AnyPublisher<Void, NetworkClientError>
}
