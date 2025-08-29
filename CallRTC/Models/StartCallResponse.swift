//
//  StartCallResponse.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

struct StartCallResponse: Codable {
    let callId: UUID
    let callerId: UUID
    let calleeId: UUID
    let callType: CallType
}