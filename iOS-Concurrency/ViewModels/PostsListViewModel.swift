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
    
    func fetchPosts() {
        if let userId = userId {
            isLoading.toggle()
            let apiService = APIService(urlSrring: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            
            apiService.getJson { (result: Result<[Post], APIError>) in
                
                defer {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                
                switch result {
                    
                case .success(let posts):
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert = true
                        self.alertMessage = error.localizedDescription + " Please try again later."
                    }
                }
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
