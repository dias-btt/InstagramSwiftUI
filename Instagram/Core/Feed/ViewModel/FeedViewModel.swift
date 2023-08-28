//
//  FeedViewModel.swift
//  Instagram
//
//  Created by Диас Сайынов on 27.08.2023.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject{
    @Published var posts = [Post]()
    
    init(){
        Task {try await fetchPosts()}
    }
    
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService().fetchFeedPosts()
    }
}
