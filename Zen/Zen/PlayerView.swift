//
//  PlayerView.swift
//  Zen
//
//  Created by Safar Safarov on 16/09/22.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    var meditationVM: MeditationViewModel
    var isPreview: Bool = false
    @State private var value: Double = 0.0
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    var body: some View {
        ZStack {
            // MARK: Background Image
            
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            // MARK: Blur View
            
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                // MARK: Dismiss Button
                
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
                // MARK: Title
                
                Text(meditationVM.meditation.title)
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 5) {
                    // MARK: Playbackk Timeline
                    Slider(value: $value, in: 0...60)
                        .accentColor(.white)
                    
                    // MARK: Playback Time
                    HStack {
                        Text("0:00")
                        
                        Spacer()
                        
                        Text("1:70")
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                }
                HStack {
                    // MARK: Repeat Button
                    PlaybackControlButton(systemName: "repeat") {
                        
                    }
                    
                    Spacer()
                    
                    // MARK: Repeat Button
                    PlaybackControlButton(systemName: "gobackward.10") {
                        
                    }
                    
                    Spacer()
                    
                    // MARK: Repeat Button
                    PlaybackControlButton(systemName: "play.circle.fill",
                                          fontSize: 55) {
                        
                    }
                    
                    Spacer()
                    // MARK: Repeat Button
                    PlaybackControlButton(systemName: "goforward.10") {
                        
                    }
                    Spacer()
                    PlaybackControlButton(systemName: "stop.fill") {
                        
                    }
                }
            }
            .padding(20 )
        }
        .onAppear(
            audioManager.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
        )
         
        .onReceive(timer) { _ in
            guard let player = audioManager.player else { return }
            value = player.currentTime
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let meditationVM = MeditationViewModel(meditation: Meditation.data)
    
    static var previews: some View {
        PlayerView(meditationVM: meditationVM, isPreview: true)
            .environmentObject(AudioManager())
    }
}
