//
//  PostsListViewModel.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/10/25.
//

import Foundation

class PostsListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String?

    var userId: Int?
    
    @MainActor
    func fetchPosts() async {
        if let userId = userId {
            isLoading.toggle()
            let apiService = APIService(urlSrring: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            
            
            defer {
                isLoading.toggle()
            }
            
            do {
                posts = try await apiService.getJson()
            } catch  {
                showAlert = true
                alertMessage = error.localizedDescription + " Please try again later."
            }
        }
    }
}

extension PostsListViewModel {
    convenience init(for preview: Bool = false) {
        self.init()
        if preview {
            self.posts = Post.mockPosts
        }
    }
        
}
