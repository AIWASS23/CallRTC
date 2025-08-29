//
//  CallEngine.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation
import WebRTC
import Combine

protocol CallEngine {
    var eventPublisher: AnyPublisher<CallEngineEvent, Never> { get }
    var delegate: CallEngineDelegate? { get set }
    func startCall(_ configuration: CallConfiguration)
    
    func acceptCall()
    func endCall()
    func declineCall()
    func switchCamera()
    func onOffMicrophone()
    func onOffCamera()
}
