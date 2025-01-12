//
//  UserAndPosts.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/12/25.
//

import Foundation

struct UserAndPosts: Identifiable {
    let id = UUID()
    let user: User
    let posts: [Post]
    var numberOfPosts: Int {
        posts.count
    }
}
