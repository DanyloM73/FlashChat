//
//  FlashChatApp.swift
//  FlashChat
//
//  Created by danylo on 08.02.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct FlashChatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
