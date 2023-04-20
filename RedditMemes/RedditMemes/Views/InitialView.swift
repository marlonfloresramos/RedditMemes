//
//  InitialView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct InitialView: View {
    @EnvironmentObject var initialSettings: InitialSettings

    var body: some View {
        switch initialSettings.state {
        case .showOnboarding:
            getLoginView()
        case .showRequestPermission:
            getRequestPermissionView()
        case .showHome:
            getHomeView()
        }
    }

    private func getLoginView() -> AnyView {
        let viewModel =
        OnboardingViewModel()
        return AnyView(
            OnboardingView(viewModel: viewModel)
                .transition(
                    AnyTransition.move(edge: .bottom)
                        .combined(with: .opacity)
                        .animation(.easeInOut(duration: 0.3))
                )
        )
    }

    private func getRequestPermissionView() -> AnyView {
        return AnyView(
            NavigationStack {
                RequestPermissionView(viewModel: RequestPermissionViewModel())
            }
            .transition(
                AnyTransition.move(edge: .bottom)
                .combined(with: .opacity)
                .animation(.easeInOut(duration: 0.3))
            )
        )
    }

    private func getHomeView() -> AnyView {
        return AnyView(
            HomeView()
                .transition(
                    AnyTransition.move(edge: .bottom)
                        .combined(with: .opacity)
                        .animation(.easeInOut(duration: 0.3))
                )
        )
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
            .environmentObject(InitialSettings())
    }
}
