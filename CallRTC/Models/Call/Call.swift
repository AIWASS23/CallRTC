//
//  Call.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

struct Call {
    let callId: UUID
    let callerId: UUID
    let calleeId: UUID
    let callType: CallType
    let isIncoming: Bool
    
    func receiverId() -> UUID {
        isIncoming ? callerId : calleeId
    }
    
    func senderId() -> UUID {
        isIncoming ? calleeId : callerId
    }
}
