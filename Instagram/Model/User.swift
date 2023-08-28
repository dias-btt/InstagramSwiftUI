//
//  User.swift
//  Instagram
//
//  Created by Диас Сайынов on 01.08.2023.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable{
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullName: String?
    var bio: String?
    let email: String
    var isCurrentUser: Bool{
        guard let currentUID = Auth.auth().currentUser?.uid else {return false}
        return currentUID == id
    }
}

extension User{
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "dsaiynov", fullName: "Dias Saiynov", email: "dias.saiynov@nu.edu.kz" ),
        .init(id: NSUUID().uuidString, username: "amyens", fullName: "Amina", email: "amina@nu.edu.kz" ),
        .init(id: NSUUID().uuidString, username: "batman", fullName: "Joe Dragon", email: "joe.dragon@nu.edu.kz" ),
        .init(id: NSUUID().uuidString, username: "spiderman", fullName: "Tom Holland", email: "tom@nu.edu.kz" ),
    ]
}
