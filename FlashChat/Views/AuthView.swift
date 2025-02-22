//
//  AuthView.swift
//  FlashChat
//
//  Created by danylo on 08.02.2025.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .font(.system(size: 25))
                .padding(.horizontal, 50)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 25))
                .padding(.horizontal, 50)
                .padding(.vertical, 10)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(isRegistering ? "Registration" : "Login") {
                if isRegistering {
                    register()
                } else {
                    login()
                }
            }
            .padding(20)
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.system(size: 20))
            .cornerRadius(10)

            Button("Switch to \(isRegistering ? "login" : "registration")") {
                isRegistering.toggle()
            }
            .padding()
        }
        .navigationTitle(K.appName)
        .navigationBarTitleDisplayMode(.large)
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                switchToChat()
            }
        }
    }

    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                switchToChat()
            }
        }
    }

    func switchToChat() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.rootViewController = UIHostingController(
                rootView: ContentView()
            )
            window.makeKeyAndVisible()
        }
    }
}


#Preview {
    AuthView()
}
