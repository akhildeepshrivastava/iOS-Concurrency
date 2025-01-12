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
    
    @MainActor
    func fetchUsers() async {
        isLoading.toggle()
        let apiService = APIService(urlSrring: "https://jsonplaceholder.typicode.com/users")
        
        defer {
            isLoading.toggle()
        }
        
        do {
            users = try await apiService.getJson()
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
            self.users = User.mockUsers
        }
    }
}
