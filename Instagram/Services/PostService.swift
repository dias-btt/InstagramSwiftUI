//
//  PostService.swift
//  Instagram
//
//  Created by Диас Сайынов on 28.08.2023.
//

import Foundation
import Firebase

struct PostService{
    
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    func fetchFeedPosts() async throws -> [Post]{
        let snapshot = try await PostService.postsCollection.getDocuments()
        var posts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})
        
        for i in 0..<posts.count{
            let post = posts[i]
            let ownerUid = post.ownerID
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        return posts
    }
    
    func fetchUserPost(uid: String) async throws -> [Post]{
        let snapshot = try await PostService.postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({try $0.data(as: Post.self)})
    }
}
