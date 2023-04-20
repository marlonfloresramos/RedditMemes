//
//  CustomButton.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

enum CustomButtonType {
    case primary
    case secondary
    case clear
}

struct CustomButton: View {
    let type: CustomButtonType
    let label: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            switch type {
            case .primary:
                Text(label)
                    .font(Font.system(size: 18).weight(.semibold))
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .clipShape(Capsule())
            case .secondary:
                Text(label)
                    .font(Font.system(size: 18).weight(.semibold))
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.orange)
                    .background(Color.clear)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1))
                    )
            case .clear:
                Text(label)
                    .font(Font.system(size: 18).weight(.semibold))
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(type: .primary, label: "Sign in") {}
    }
}
