//
//  TokenResponse.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation

struct TokenResponse: Codable {
    let token: String
    let refreshToken: String
}