//
//  CallClient.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation
import Combine

protocol CallClient {
    func startCall(dto: StartCallRequest) -> AnyPublisher<StartCallResponse, NetworkClientError>
}