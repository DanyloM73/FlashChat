//
//  ChatView.swift
//  FlashChat
//
//  Created by danylo on 08.02.2025.
//

import SwiftUI
import FirebaseAuth

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var messageText = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            MessageRow(message: message)
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) { () in
                    if let lastMessage = viewModel.messages.last {
                        withAnimation {
                            scrollView.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }

            HStack {
                TextField("Message...", text: $messageText)
                    .font(.system(size: 20))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isFocused)

                Button(action: {
                    viewModel.sendMessage(messageText)
                    messageText = ""
                    isFocused = false
                }) {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 30.0, height: 30.0)
                        .padding(.horizontal)
                        
                }
            }
            .padding()
        }
        .navigationTitle(K.appName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button("Logout") {
            logout()
        })
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first {
                window.rootViewController = UIHostingController(
                    rootView: ContentView()
                )
                window.makeKeyAndVisible()
            }
        } catch {
            print("Logout error: \(error.localizedDescription)")
        }
    }
}


#Preview {
    ChatView()
}

