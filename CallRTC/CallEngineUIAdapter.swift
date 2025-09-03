//
//  CallEngineUIAdapter.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 03/09/25.
//


import WebRTC

final class CallEngineUIAdapter: CallEngineDelegate {
    private weak var localRenderer: RTCVideoRenderer?
    private weak var remoteRenderer: RTCVideoRenderer?
    
    init(localRenderer: RTCVideoRenderer, remoteRenderer: RTCVideoRenderer) {
        self.localRenderer = localRenderer
        self.remoteRenderer = remoteRenderer
    }
    
    func localVideoRenderer() -> RTCVideoRenderer {
        guard let localRenderer else {
            fatalError("⚠️ localRenderer não foi configurado!")
        }
        return localRenderer
    }
    
    func remoteVideoRenderer() -> RTCVideoRenderer {
        guard let remoteRenderer else {
            fatalError("⚠️ remoteRenderer não foi configurado!")
        }
        return remoteRenderer
    }
}
