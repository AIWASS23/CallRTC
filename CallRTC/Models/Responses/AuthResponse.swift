//
//  AuthResponse.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation

struct AuthResponse: Codable {
    let userId: UUID
    let email: String
    let token: TokenResponse
}
