//
//  SearchViewModel.swift
//  Instagram
//
//  Created by Диас Сайынов on 14.08.2023.
//

import Foundation

class SearchViewModel: ObservableObject{
    
    @Published var users = [User]()
    
    init() {
        Task {try await fetchAllUsers()}
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
