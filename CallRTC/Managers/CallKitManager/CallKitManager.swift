//
//  CallKitManager.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation
import CallKit
import Combine

protocol CallKitManager {
    var publisher: AnyPublisher<CallEvent, Never> { get }
    func reportIncomingCall(payload: VoIPNotificationPayload)
}