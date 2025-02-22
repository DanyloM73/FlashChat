//
//  ContentView.swift
//  FlashChat
//
//  Created by danylo on 08.02.2025.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        NavigationStack {
            if Auth.auth().currentUser != nil {
                ChatView()
            } else {
                AuthView()
            }
        }
    }
}
