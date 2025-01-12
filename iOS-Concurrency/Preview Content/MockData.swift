//
//  MockData.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/10/25.
//

import Foundation

extension User {
    static var mockUsers: [User] {
        Bundle.main.decode([User].self, from: "users.json")
    }
        
    static var mockUse: User {
        Self.mockUsers[0]
    }
}


extension Post {
    static var mockPosts: [Post] {
        Bundle.main.decode([Post].self, from: "posts.json")
    }
        
    static var mockPost: Post {
        Self.mockPosts[0]
    }
    
    static var mockSingleUserPosts: [Post] {
        
        Self.mockPosts.filter { $0.userId == 1 }
    }
}


extension UserAndPosts {
    static var mockUserAndPosts: [UserAndPosts] {
        var userAndPosts: [UserAndPosts] = []
        let users = User.mockUsers
        for user in users {
            let userPosts = Post.mockPosts.filter { $0.userId == user.id }
            userAndPosts.append(UserAndPosts(user: user, posts: userPosts))
        }
        return userAndPosts
    }
}
