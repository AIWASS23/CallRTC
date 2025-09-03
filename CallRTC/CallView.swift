//
//  ContentView.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//

import SwiftUI
import WebRTC

struct CallView: View {
    @StateObject private var viewModel: CallViewModel
    
    // Views de vídeo do WebRTC
    private let localVideoView = RTCMTLVideoView()
    private let remoteVideoView = RTCMTLVideoView()
    
    init(engine: CallEngine, config: CallConfiguration?) {
        let vm = CallViewModel(callEngine: engine, callConfiguration: config)
        _viewModel = StateObject(wrappedValue: vm)
        
        self.localVideoView.videoContentMode = .scaleAspectFill
        self.remoteVideoView.videoContentMode = .scaleAspectFill
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📞 Chamada em andamento")
                .font(.title2)
            
            // Video remoto
            RTCVideoView(renderer: remoteVideoView)
                .frame(maxWidth: .infinity, maxHeight: 400)
                .background(Color.black)
                .cornerRadius(12)
            
            // Video local (PIP)
            RTCVideoView(renderer: localVideoView)
                .frame(width: 120, height: 180)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 1))
            
            HStack(spacing: 16) {
                Button("Aceitar") { viewModel.acceptCall() }
                Button("Recusar") { viewModel.declineCall() }
                Button("Encerrar") { viewModel.endCall() }
            }
            
            HStack(spacing: 16) {
                Button("Microfone") { viewModel.manageMicrophone() }
                Button("Câmera") { viewModel.manageCamera() }
                Button("Trocar Câmera") { viewModel.switchCamera() }
            }
        }
        .padding()
        .onReceive(viewModel.publisher) { event in
            if case .callEnded = event {
                print("⚠️ A chamada terminou — feche a tela aqui")
            }
        }
        .onAppear {
            // 🔑 agora configuramos os renderers aqui
            viewModel.setupRenderers(local: localVideoView, remote: remoteVideoView)
            viewModel.processCall()
        }
    }
}

struct RTCVideoView: UIViewRepresentable {
    var renderer: RTCVideoRenderer
    
    func makeUIView(context: Context) -> UIView {
        if let view = renderer as? UIView {
            return view
        }
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

