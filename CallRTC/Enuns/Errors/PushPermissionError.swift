//
//  PushPermissionError.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

enum PushPermissionError: Error {
    case notDetermined
    case denied
    case authorized
    case provisional
    case ephemeral
    case systemError(Error)
}
