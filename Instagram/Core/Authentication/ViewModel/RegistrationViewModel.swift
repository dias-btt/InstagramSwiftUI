//
//  RegistrationViewModel.swift
//  Instagram
//
//  Created by Диас Сайынов on 04.08.2023.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel: ObservableObject{
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""

    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
}
