//
//  LoginView.swift
//  Instagram
//
//  Created by Диас Сайынов on 30.07.2023.
//

import SwiftUI

struct LoginView: View {

    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                
                //logo
                Image("insta")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                
                //text fields
                TextField("Enter your email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(IGTextFieldModifier())
                
                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(IGTextFieldModifier())
            }
            
            //forgot password
            Button {
                
            } label: {
                Text("Forgot Password?")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.top)
                    .padding(.trailing, 28)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            //login button
            Button {
                Task {try await viewModel.signIn()}
            } label: {
                Text("Login")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 44)
                    .foregroundColor(.white)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            HStack{
                Rectangle()
                    .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                Text("OR")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Rectangle()
                    .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
            }
            .foregroundColor(.gray)
            HStack{
                Image("facebook")
                    .resizable()
                    .frame(width: 35, height: 30)
                Text("Continue with Facebook")
                    .foregroundColor(.blue)
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            .padding(.top, 8)
            
            Spacer()
            
            Divider()
            
            NavigationLink {
                AddEmailView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                HStack(spacing: 3){
                    Text("Don't have an account")
                    Text("Sign Up")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
