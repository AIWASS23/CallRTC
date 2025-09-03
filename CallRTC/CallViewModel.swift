//
//  CallViewModel.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Combine
import Foundation
import WebRTC

enum Event {
    case callEnded
}

class CallViewModel: ObservableObject {
    
    var publisher: AnyPublisher<Event, Never> {
        subject.eraseToAnyPublisher()
    }
    
    private let subject = PassthroughSubject<Event, Never>()
    private var callEngine: CallEngine
    private let callConfiguration: CallConfiguration?
    private var adapter: CallEngineUIAdapter?
    
    weak var callEngineDelegate: CallEngineDelegate? {
        set {
            callEngine.delegate = newValue
        }
        get {
            callEngine.delegate
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(callEngine: CallEngine, callConfiguration: CallConfiguration?) {
        self.callEngine = callEngine
        self.callConfiguration = callConfiguration
        
        bindCallEngine()
    }
    
    func processCall() {
        if let config = callConfiguration {
            callEngine.startCall(config)
        }
    }
    
    func setupRenderers(local: RTCVideoRenderer, remote: RTCVideoRenderer) {
        let adapter = CallEngineUIAdapter(localRenderer: local, remoteRenderer: remote)
        self.adapter = adapter
        self.callEngineDelegate = adapter 
    }
    
    private func bindCallEngine() {
        callEngine.eventPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .callEnded:
                    self?.subject.send(.callEnded)
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    deinit {
        print("CallViewModel deinited!")
    }
}

extension CallViewModel {
    func acceptCall() {
        callEngine.acceptCall()
    }
    
    func endCall() {
        callEngine.endCall()
    }
    
    func declineCall() {
        callEngine.declineCall()
    }
    
    func manageMicrophone() {
        callEngine.onOffMicrophone()
    }
    
    func manageCamera() {
        callEngine.onOffCamera()
    }
    
    func switchCamera() {
        callEngine.switchCamera()
    }
}

