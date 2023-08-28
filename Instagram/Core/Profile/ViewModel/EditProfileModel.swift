//
//  EditProfileModel.swift
//  Instagram
//
//  Created by Диас Сайынов on 16.08.2023.
//

import Foundation
import Firebase
import PhotosUI
import SwiftUI

@MainActor
class EditProfileModel: ObservableObject{
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem?{
        didSet{Task {await loadImage(fromItem: selectedImage)}}
    }
    
    @Published var profileImage: Image?
    @Published var fullname = ""
    @Published var bio = ""
    
    private var uiImage: UIImage?
    
    init(user: User){
        self.user = user
        
        if let fullname = user.fullName{
            self.fullname = fullname
        }
        
        if let bio = user.bio{
            self.bio = bio
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async{
        guard let item = item else {return}
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws{
        //update image if changed
        var data = [String: Any]()
        if let uiImage = uiImage{
            let imageURL = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageURL
        }
        
        //update name if changed
        if !fullname.isEmpty && user.fullName != fullname{
            data["fullname"] = fullname
        }
        
        //update bio if changed
        if !bio.isEmpty && user.bio != bio{
            data["bio"] = bio
        }
        
        if !data.isEmpty{
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
