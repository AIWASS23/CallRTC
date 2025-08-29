//
//  WebRTCEvent.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation
import WebRTC

enum WebRTCEvent {
    case iceDiscovered(RTCIceCandidate)
    case error(Error)
}