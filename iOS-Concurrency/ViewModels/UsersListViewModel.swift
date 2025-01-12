//
//  UsersListViewModel.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/10/25.
//

import Foundation

class UsersListViewModel: ObservableObject {
    
    @Published var userAndPosts: [UserAndPosts] = []
    @Published var isLoading = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String?
    
    @MainActor
    func fetchUsers() async {
        isLoading.toggle()
        let apiService = APIService(urlSrring: "https://jsonplaceholder.typicode.com/users")
        let apiServicePosts = APIService(urlSrring: "https://jsonplaceholder.typicode.com/posts")
        
        defer {
            isLoading.toggle()
        }
        
        do {
//            let users: [User] = try await apiService.getJson()
//            let posts: [Post] = try await apiServicePosts.getJson()
            
            async let users: [User] = try await apiService.getJson()
            async let posts: [Post] = try await apiServicePosts.getJson()
            
            let (fetchUsers, fetchPosts) = await (try users, try posts)
            
            for user in fetchUsers {
                let userPosts = fetchPosts.filter { $0.userId == user.id }
                userAndPosts.append(UserAndPosts(user: user, posts: userPosts))
            }

        } catch  {
            showAlert = true
            alertMessage = error.localizedDescription + " Please try again later."
        }
    }
}

extension UsersListViewModel {
    convenience init(for preview: Bool = false) {
        self.init()
        if preview {
            self.userAndPosts = UserAndPosts.mockUserAndPosts
        }
    }
}
