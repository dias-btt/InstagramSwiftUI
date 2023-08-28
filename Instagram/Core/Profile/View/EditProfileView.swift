//
//  EditProfileView.swift
//  Instagram
//
//  Created by Диас Сайынов on 16.08.2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    let user: User
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileModel
    
    init(user: User){
        self.user = user
        self._viewModel = StateObject(wrappedValue: EditProfileModel(user: user))
    }
    
    var body: some View {
        VStack{
            
            //toolbar
            HStack{
                Button("Cancel"){
                    dismiss()
                }
                
                Spacer()
                
                Text("Edit profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    //update profile
                    Task {try await viewModel.updateUserData()}
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }

            }
            .padding(.horizontal)
            
            Divider()
            
            //edit profile pic
            PhotosPicker(selection: $viewModel.selectedImage){
                VStack {
                    if let image = viewModel.profileImage{
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    } else{
                        CircularProfileImageView(user: user, size: .Large)
                    }

                    Text("Edit profile picture")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Divider()
                }
            }
            .padding(.vertical, 8)
                    
            //edit profile bio
            VStack{
                EditProfileRowView(title: "Name", placeholder: "Enter your name...", text: $viewModel.fullname)
                EditProfileRowView(title: "Bio", placeholder: "Enter bio...", text: $viewModel.bio)
            }
            Divider()

            Spacer()
        }
    }
}

struct EditProfileRowView: View{
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View{
        HStack{
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            VStack{
                TextField(placeholder, text: $text)
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.MOCK_USERS[0])
    }
}
