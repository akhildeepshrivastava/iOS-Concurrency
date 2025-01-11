//
//  User.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/10/25.
//

import Foundation

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let name, username, email: String
}

