//
//  KeychainError.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//

import Foundation

enum KeychainError: Error {
    case decodingFailed
    case encodingFailed
    case itemNotFound
    case duplicateItem
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
    
    var localizedDescription: String {
        switch self {
        case .encodingFailed:
            return "Failed to encode item for keychain storage"
        case .decodingFailed:
            return "Failed to decode item from keychain"
        case .itemNotFound:
            return "Item not found in keychain"
        case .duplicateItem:
            return "Item already exists in keychain"
        case .unexpectedPasswordData:
            return "Unexpected password data format"
        case .unhandledError(let status):
            return "Keychain error: \(status)"
        }
    }
}
