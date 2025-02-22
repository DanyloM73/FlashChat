//
//  ChatViewModel.swift
//  FlashChat
//
//  Created by danylo on 08.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    private let db = Firestore.firestore()

    init() {
        loadMessages()
    }

    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Messages loading error: \(error.localizedDescription)")
                    return
                }

                DispatchQueue.main.async {
                    self.messages = querySnapshot?.documents.compactMap { doc in
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String,
                           let body = data[K.FStore.bodyField] as? String {
                            return Message(id: doc.documentID, sender: sender, body: body)
                        }
                        return nil
                    } ?? []
                }
            }
    }

    func sendMessage(_ text: String) {
        guard let sender = Auth.auth().currentUser?.email else { return }
        let newMessage = [
            K.FStore.senderField: sender,
            K.FStore.bodyField: text,
            K.FStore.dateField: Date().timeIntervalSince1970
        ] as [String : Any]

        db.collection(K.FStore.collectionName).addDocument(data: newMessage) { error in
            if let error = error {
                print("Message sending error: \(error.localizedDescription)")
            }
        }
    }
}
