//
//  UsersListViewModel.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/10/25.
//

import Foundation

class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String?
    
    func fetchUsers() {
        isLoading.toggle()
        let apiService = APIService(urlSrring: "https://jsonplaceholder.typicode.com/users")
        
        apiService.getJson { (result: Result<[User], APIError>) in
            
            defer {
                DispatchQueue.main.async {
                    self.isLoading.toggle()
                }
            }
            
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
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

extension UsersListViewModel {
    convenience init(for preview: Bool = false) {
        self.init()
        if preview {
            self.users = User.mockUsers
        }
    }
}
