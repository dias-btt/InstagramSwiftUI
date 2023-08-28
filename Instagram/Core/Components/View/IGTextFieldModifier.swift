//
//  IGTextFieldModifier.swift
//  Instagram
//
//  Created by Диас Сайынов on 31.07.2023.
//

import Foundation
import SwiftUI

struct IGTextFieldModifier: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}
