//
//  CallEngineDelegate.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation
import WebRTC

protocol CallEngineDelegate: AnyObject {
    func localVideoRenderer() -> RTCVideoRenderer
    func remoteVideoRenderer() -> RTCVideoRenderer
}


