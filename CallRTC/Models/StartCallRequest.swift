//
//  StartCallRequest.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

struct StartCallRequest: Codable {
    let calleeId: UUID
    let callType: CallType
}