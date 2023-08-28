//
//  AuthService.swift
//  Instagram
//
//  Created by Диас Сайынов on 04.08.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

class AuthService{
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init(){
        Task {try await loadUser()}
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUser()
        }catch{
            print("DEBUG: Failed to register user \(error)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await self.uploadData(uid: result.user.uid, username: username, email: email)
        }catch{
            print("DEBUG: Failed to register user \(error)")
        }
    }
    
    @MainActor
    func loadUser() async throws{
        self.userSession = Auth.auth().currentUser
        guard let currentUID = userSession?.uid else {return}
        self.currentUser = try await UserService.fetchUser(withUid: currentUID)
    }
    
    func signout(){
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    private func uploadData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
