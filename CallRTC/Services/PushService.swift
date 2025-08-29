//
//  PushPermissionError.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation
import Combine
import PushKit
import UserNotifications


protocol PushService {
    var voipPushPublisher: AnyPublisher<VoIPNotificationPayload, Never> { get }
    var regularPushPublisher: AnyPublisher<RegularNotificationPayload, Never> { get }
    func requestNotificationPermission() -> AnyPublisher<Void, PushPermissionError>
    func registerRegularToken(_ token: Data)
    func registerVoIPToken(_ token: Data)
    func handleVoIPPayload(_ payload: PKPushPayload)
    func handleRemoteNotification(_ userInfo: [AnyHashable : Any])
}
