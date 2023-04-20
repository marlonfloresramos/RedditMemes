//
//  OnboardingPageView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: 54) {
            VStack(spacing: 46) {
                Image(page.imageName)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                VStack(spacing: 23) {
                    Text(page.title)
                        .font(Font.system(size: 36).weight(.semibold))
                    Text(page.subTitle)
                        .font(Font.system(size: 16).weight(.regular))
                }
            }
            VStack(spacing: 23) {
                HStack {
                    CustomButton(type: .primary, label: "Sign In") {
                        //
                    }
                    Spacer(minLength: 40)
                    CustomButton(type: .secondary, label: "Register") {
                        //
                    }
                }
                Button {
                    //
                } label: {
                    Text("Continue as a GUEST")
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(
            page: OnboardingPage(
                imageName: "Onboarding/page1",
                title: "One in All",
                subTitle: "Increasing Prosperity With Positive Thinking"
            )
        )
    }
}
