//
//  PostsListView.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/10/25.
//

import SwiftUI

struct PostsListView: View {
    
    #warning("remove the forPreview flag and or set it to false broefe final commit")
    @StateObject private var vm: PostsListViewModel = PostsListViewModel(for: false)
    let userId: Int?

    var body: some View {
            List {
                ForEach(vm.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.callout)
                            .foregroundStyle(.secondary)

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
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .task {
                vm.userId = userId
                await vm.fetchPosts()
            }
    }
}

#Preview {
    NavigationStack {
        PostsListView(userId: 1)
    }
}
