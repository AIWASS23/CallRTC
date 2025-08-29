//
//  RegularNotificationPayload.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


struct RegularNotificationPayload: Codable {
    let aps: AppleAPS
    let type: String
    let data: [String: String]?
    let messageId: String?
    let userId: String?
}