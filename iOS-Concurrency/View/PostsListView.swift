//
//  PostsListView.swift
//  iOS-Concurrency
//
//  Created by Akhil Deep Shrivastava on 1/10/25.
//

import SwiftUI

struct PostsListView: View {
    
    #warning("remove the forPreview flag and or set it to false broefe final commit")
    var posts: [Post]

    var body: some View {
            List {
                ForEach(posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.callout)
                            .foregroundStyle(.secondary)

                    }
                }
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        PostsListView(posts: Post.mockSingleUserPosts)
    }
}
