//
//  CustomColors.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct CustomColor {
    static let primaryGradient = LinearGradient(
        colors: [Color("Colors/pink1"), Color("Colors/orange1")],
        startPoint: .leading, endPoint: .trailing
    )

    static let orange2 = Color("Colors/orange2")
    static let searchBackground = Color("Colors/searchBackground")
    static let searchText = Color("Colors/searchText")
    static let background = Color("Colors/background")
    static let text = Color("Colors/text")
}
