//
//  AnswerPayload.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

struct AnswerPayload: Codable {
    let callerId: UUID
    let calleeId: UUID
    let callType: CallType
    let sdp: String
}