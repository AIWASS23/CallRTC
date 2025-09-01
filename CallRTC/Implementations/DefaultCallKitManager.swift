//
//  DefaultCallKitManager.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//

import Foundation
import UIKit
import CallKit
import Combine


class DefaultCallKitManager: NSObject, CallKitManager {
    private let provider: CXProvider
    private let subject = PassthroughSubject<CallEvent, Never>()
    private var payload: VoIPNotificationPayload?
    
    var publisher: AnyPublisher<CallEvent, Never> {
        subject.eraseToAnyPublisher()
    }
    
    override init() {
        let config = CXProviderConfiguration()
        config.includesCallsInRecents = true
        config.supportsVideo = true
        config.maximumCallsPerCallGroup = 1
        config.supportedHandleTypes = [.generic]

        self.provider = CXProvider(configuration: config)

        super.init()
        self.provider.setDelegate(self, queue: nil)
    }

    func reportIncomingCall(payload: VoIPNotificationPayload) {
        if UIApplication.shared.applicationState == .active {
            subject.send(.ringingInApp)
            return
        }
        
        self.payload = payload
        
        let update = CXCallUpdate()
        
        update.remoteHandle = CXHandle(type: .generic, value: payload.callerName)
        update.hasVideo = payload.callType == .video
        update.localizedCallerName = payload.callerName

        provider.reportNewIncomingCall(with: payload.callId, update: update) { error in
            if let error = error {
                print("❌ CallKit report error: \(error)")
            } else {
                print("✅ CallKit incoming call reported")
                self.subject.send(.ringing)
            }
        }
    }
}

extension DefaultCallKitManager: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
        print("CallKit provider reset.")
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        print("✅ User answered the call.")
        action.fulfill()
        subject.send(.accepted)
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        print("✅ User ended the call.")
        action.fulfill()
        subject.send(.declined)
    }
}
