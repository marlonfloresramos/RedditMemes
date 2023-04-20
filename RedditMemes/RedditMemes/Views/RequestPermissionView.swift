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
                            viewModel.goToNextScreen {
                                goToNextScreen = true
                            } flowFinished: {
                                initialSettings.state = .showHome
                            }
                        }
                    }
                    .frame(height: 50)
                    CustomButton(type: .clear, label: viewModel.page.secondaryButton) {
                        viewModel.goToNextScreen {
                            goToNextScreen = true
                        } flowFinished: {
                            initialSettings.state = .showHome
                        }
                    }
                    .frame(height: 50)
                }
                .frame(maxWidth: 195)
            }
            .padding(.horizontal, 60)
        .navigationBarBackButtonHidden(true)
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
        RequestPermissionView(viewModel: RequestPermissionViewModel())
    }
}
