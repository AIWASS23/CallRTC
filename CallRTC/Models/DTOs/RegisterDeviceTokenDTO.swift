//
//  RegisterDeviceTokenDTO.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation

struct RegisterDeviceTokenDTO: Codable {
    let token: String
    let isVoIP: Bool
}
