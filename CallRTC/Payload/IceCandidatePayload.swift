//
//  IceCandidatePayload.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

struct IceCandidatePayload: Codable {
    let senderId: UUID
    let receiverId: UUID
    let candidate: String
    let sdpMid: String?
    let sdpMLineIndex: Int?
}
