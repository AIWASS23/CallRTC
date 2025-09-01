//
//  RegisterDeviceTokenResponse.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation

struct RegisterDeviceTokenResponse: Codable {
    let token: String
    let success: Bool
}
