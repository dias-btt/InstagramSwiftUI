//
//  Post.swift
//  Instagram
//
//  Created by Диас Сайынов on 01.08.2023.
//

import Foundation
import Firebase

struct Post: Identifiable, Hashable, Codable{
    let id: String
    let ownerID: String
    let picUrl: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    var user: User?
}

extension Post{
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString, ownerID: NSUUID().uuidString, picUrl: "me", caption: "This is me", timestamp: Timestamp(), likes: 1, user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString, ownerID: NSUUID().uuidString, picUrl: "photo", caption: "Itachi GOAT", timestamp: Timestamp(), likes: 1, user: User.MOCK_USERS[1]),
        .init(id: NSUUID().uuidString, ownerID: NSUUID().uuidString, picUrl: "tom", caption: "Smiling", timestamp: Timestamp (), likes: 1900000, user: User.MOCK_USERS[3]),
    ]
}
