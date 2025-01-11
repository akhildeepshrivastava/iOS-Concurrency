//
//  Post.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/10/25.
//

import Foundation

// MARK: - Post
struct Post: Codable, Identifiable {
    let userId, id: Int
    let title, body: String
}
