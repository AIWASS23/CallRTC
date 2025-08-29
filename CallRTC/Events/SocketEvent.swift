//
//  SocketEvent.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

enum SocketEvent: String, Codable {
    case redyToOffer
    case offer
    case answer
    case iceCandidate
    case endCall
    case ping
    case error
}
