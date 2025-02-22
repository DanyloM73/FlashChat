//
//  Message.swift
//  FlashChat
//
//  Created by danylo on 08.02.2025.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var sender: String
    var body: String
}
