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
                ForEach(vm.userAndPosts) { userAndPosts in
                    
                    NavigationLink {
                        PostsListView(posts: userAndPosts.posts)
                    } label: {
                        //
                        VStack(alignment: .leading) {
                            HStack {
                                Text(userAndPosts.user.name)
                                    .font(.title)
                                Spacer()
                                Text("Posts: \(userAndPosts.posts.count)")
                                    .font(.callout)
                                    
                            }
                            Text(userAndPosts.user.email)
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
