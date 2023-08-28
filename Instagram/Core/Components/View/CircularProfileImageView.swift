//
//  CircularProfileImageView.swift
//  Instagram
//
//  Created by Диас Сайынов on 26.08.2023.
//

import SwiftUI
import Kingfisher

enum profileImageSize{
    case xSmall
    case Small
    case Medium
    case Large
    
    var dimension: CGFloat{
        switch self{
        case .xSmall:
            return 40
        case .Small:
            return 48
        case .Medium:
            return 64
        case .Large:
            return 80
        }
    }
}

struct CircularProfileImageView: View {
    
    let user: User
    let size: profileImageSize
    
    var body: some View {
        if let imageURL = user.profileImageUrl{
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else{
            Image("default")
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        }
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: User.MOCK_USERS[0 ], size: .Large)
    }
}
