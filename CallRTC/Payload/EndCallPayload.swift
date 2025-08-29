//
//  EndCallPayload.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

struct EndCallPayload: Codable {
    let callId: UUID
    let senderId: UUID
    let receiverId: UUID
    let reason: EndCallReason
}
