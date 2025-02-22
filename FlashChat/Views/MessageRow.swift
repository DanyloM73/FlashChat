//
//  MessageRow.swift
//  FlashChat
//
//  Created by danylo on 08.02.2025.
//

import SwiftUI
import FirebaseAuth

struct MessageRow: View {
    let message: Message

    var isCurrentUser: Bool {
        message.sender == Auth.auth().currentUser?.email
    }

    var senderInitial: String {
        message.sender.first?.uppercased() ?? "?"
    }

    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
                
                Text(message.body)
                    .padding(10)
                    .font(.system(size: 18, weight: .medium))
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                avatarView()
            } else {
                avatarView()
                
                Text(message.body)
                    .padding(10)
                    .font(.system(size: 18, weight: .medium))
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func avatarView() -> some View {
        Text(senderInitial)
            .font(.system(size: 18, weight: .bold))
            .frame(width: 40, height: 40)
            .background(isCurrentUser ? Color.blue : Color.gray.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Circle())
    }
}


#Preview {
    MessageRow(message: Message(id: "1", sender: "user@example.com", body: "Test message"))
}
