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
    
    init(engine: CallEngine, config: CallConfiguration?) {
        _viewModel = StateObject(
            wrappedValue: CallViewModel(callEngine: engine, callConfiguration: config)
        )
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📞 Chamada em andamento")
                .font(.title2)
            
            HStack(spacing: 16) {
                Button("Aceitar") {
                    viewModel.acceptCall()
                }
                Button("Recusar") {
                    viewModel.declineCall()
                }
                Button("Encerrar") {
                    viewModel.endCall()
                }
            }
            
            HStack(spacing: 16) {
                Button("Microfone") {
                    viewModel.manageMicrophone()
                }
                Button("Câmera") {
                    viewModel.manageCamera()
                }
                Button("Trocar Câmera") {
                    viewModel.switchCamera()
                }
            }
        }
        .padding()
        // Escuta os eventos vindos do CallViewModel
        .onReceive(viewModel.publisher) { event in
            switch event {
            case .callEnded:
                print("⚠️ A chamada terminou — você pode fechar a tela aqui")
            }
        }
        .onAppear {
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

