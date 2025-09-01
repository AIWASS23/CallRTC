//
//  NetworkClient.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation
import Combine

protocol NetworkClient {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkClientError>
}
