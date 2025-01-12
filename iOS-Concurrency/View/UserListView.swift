//
//  ContentView.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/10/25.
//

import SwiftUI

struct UserListView: View {
    
    #warning("remove the forPreview flag and or set it to false broefe final commit")
    @StateObject private var vm: UsersListViewModel = UsersListViewModel(for: false)

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.users) { user in
                    
                    NavigationLink {
                        PostsListView(userId: user.id)
                    } label: {
                        //
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title)
                            Text(user.email)
                        }
                    }
                    
                }
            }
            .overlay {
                if vm.isLoading {
                    ProgressView()
                }
            }
            .alert("Application Error", isPresented: $vm.showAlert, actions: {
                Button("OK") {}
            }, message: {
                if let error = vm.alertMessage {
                    Text(error)
                }
            })
            .navigationTitle("Users")
            .listStyle(.plain)
            .task {
                await vm.fetchUsers()

            }
        }
    }
}

#Preview {
    UserListView()
}
