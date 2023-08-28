//
//  PostGridViewModel.swift
//  Instagram
//
//  Created by Диас Сайынов on 28.08.2023.
//

import Foundation

class PostGridViewModel: ObservableObject{
    private let user: User
    @Published var posts = [Post]()
    
    init(user: User){
        self.user = user
        Task{try await fetchUserPosts()}
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService().fetchUserPost(uid: user.id)
        for i in 0..<posts.count{
            posts[i].user = self.user
        }
    }
}
