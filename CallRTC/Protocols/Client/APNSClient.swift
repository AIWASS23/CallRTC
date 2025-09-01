//
//  APNSClient.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Combine
import Foundation

protocol APNSClient {
    func registerAPNsDeviceToken(with request: RegisterDeviceTokenDTO) -> AnyPublisher<RegisterDeviceTokenResponse, NetworkClientError>
    func registerVoIPDeviceToken(with request: RegisterDeviceTokenDTO) -> AnyPublisher<RegisterDeviceTokenResponse, NetworkClientError>
}