//
//  SocketMessage.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

struct SocketMessage<T: Codable>: Codable {
    let event: SocketEvent
    let data: T
}
