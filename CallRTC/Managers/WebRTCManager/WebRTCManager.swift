//
//  WebRTCManager.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Combine
import WebRTC

protocol WebRTCManager {
    var eventPublisher: AnyPublisher<WebRTCEvent, Never> { get }
    var localVideoView: RTCVideoRenderer? { get set }
    var remoteVideoView: RTCVideoRenderer? { get set }
    
    func setupPeerConnectionAndMedia()
    
    func toggleSpeaker()
    func toggleMicrophone()
    func toggleCamera()
    func switchCamera()
    
    func createOffer(completion: @escaping (String?) -> Void)
    func set(remoteOffer sdpString: String, completion: @escaping (Bool) -> Void)
    
    func createAnswer(completion: @escaping (String?) -> Void)
    func set(remoteAnswer sdpString: String, completion: @escaping (Bool) -> Void)
    
    func addIceCandidate(_ candidate: IceCandidatePayload)
    
    func terminate()
}