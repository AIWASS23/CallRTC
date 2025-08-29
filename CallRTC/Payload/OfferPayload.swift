//
//  OfferPayload.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

struct OfferPayload: Codable {
    let callId: UUID
    let callerId: UUID
    let calleeId: UUID
    let callType: CallType
    let sdp: String
}
