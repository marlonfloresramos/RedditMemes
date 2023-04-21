//
//  RequestPermissionView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct RequestPermissionView: View {
    @StateObject var viewModel: RequestPermissionViewModel
    @State var goToNextScreen: Bool = false
    @EnvironmentObject var initialSettings: InitialSettings
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        ZStack {
            NavigationLink(destination: getNextView(), isActive: $goToNextScreen) { EmptyView() }
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 48) {
                Image(viewModel.page.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 262, height: 230)
                VStack(spacing: 8) {
                    Text(viewModel.page.title)
                        .font(Font.system(size: 20).weight(.semibold))
                    Text(viewModel.page.subTitle)
                        .font(Font.system(size: 15).weight(.regular))
                        .multilineTextAlignment(.center)
                }
                VStack(spacing: 24) {
                    CustomButton(type: .primary, label: viewModel.page.primaryButton) {
                        viewModel.requestPermission { _ in
                            validatePermission()
                        }
                    }
                    .frame(height: 50)
                    CustomButton(type: .clear, label: viewModel.page.secondaryButton) {
                        toNextScreen()
                    }
                    .frame(height: 50)
                }
                .frame(maxWidth: 195)
            }
            .padding(.horizontal, 60)
        .navigationBarBackButtonHidden(true)
        }
        .onChange(of: locationManager.authorizationStatus) { _ in
            toNextScreen()
        }
    }

    func validatePermission() {
        if viewModel.page.type == .location {
            if locationManager.authorizationStatus == .notDetermined {
                locationManager.requestAuthorization()
            } else if locationManager.authorizationStatus == .denied {
                viewModel.permissionsManager.goToSettings {
                    toNextScreen()
                }
            } else {
                toNextScreen()
            }
        } else {
            toNextScreen()
        }
    }

    func toNextScreen() {
        viewModel.goToNextScreen {
            goToNextScreen = true
        }
    }

    func getNextView() -> AnyView {
        return AnyView(
            RequestPermissionView(viewModel: viewModel)
        )
    }
}

struct RequestPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        RequestPermissionView(viewModel: RequestPermissionViewModel {})
    }
}
