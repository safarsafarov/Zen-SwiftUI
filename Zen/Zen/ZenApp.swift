//
//  ZenApp.swift
//  Zen
//
//  Created by Safar Safarov on 16/09/22.
//

import SwiftUI

@main
struct ZenApp: App {
    @StateObject var audioManager = AudioManager()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
