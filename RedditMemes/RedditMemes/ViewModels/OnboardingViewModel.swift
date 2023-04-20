//
//  OnboardingViewModel.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var pages: [OnboardingPage] = [
        OnboardingPage(
            imageName: "Onboarding/page1",
            title: "One in All",
            subTitle: "Increasing Prosperity With Positive Thinking"
        ),
        OnboardingPage(
            imageName: "Onboarding/page2",
            title: "Easy to use",
            subTitle: "A Great Way To Generate All The MotivationYou Need To Get Fit"
        )
    ]
}
