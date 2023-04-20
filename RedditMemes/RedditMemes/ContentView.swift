//
//  ContentView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct OnboardingScreen: View {
    var body: some View {
        VStack(spacing: 54) {
            VStack(spacing: 46) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                VStack(spacing: 23) {
                    Text("One in All")
                    Text("Increasing Prosperity With Positive Thinking")
                }
            }
            VStack(spacing: 23) {
                HStack {
                    Button {
                        //
                    } label: {
                        Text("Sign In")
                    }
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("Register")
                    }
                }
                Button {
                    //
                } label: {
                    Text("Continue as a GUEST")
                }
            }
        }
        .padding(20)
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
