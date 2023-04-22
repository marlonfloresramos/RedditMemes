//
//  HomeView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @ObservedObject var viewModel: HomeViewModel
    @FocusState var isTextFieldFocused: Bool
    @State var showSettings: Bool = false

    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(CustomColor.searchText)
            TextField("Search", text: $viewModel.searchText)
                .font(Font.system(size: 16))
                .foregroundColor(CustomColor.searchText)
                .focused($isTextFieldFocused)
        }
        .padding(10)
        .background(CustomColor.searchBackground)
        .cornerRadius(4)
    }

    var body: some View {
        if !networkMonitor.isConnected {
            WithoutNetworkView()
        } else {
            NavigationStack {
                ZStack {
                    CustomColor.background
                        .ignoresSafeArea()
                    VStack(spacing: 16) {
                        HStack {
                            Button {
                                showSettings = true
                            } label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(CustomColor.searchText)
                            }
                            Spacer()
                        }
                        searchBar
                        if viewModel.noResults {
                            NoResultsView()
                        } else {
                            CustomScrollView(showsIndicators: false) { _ in } content: {
                                LazyVStack(spacing: 20) {
                                    ForEach(viewModel.posts) { post in
                                        VStack {
                                            HomeCardView(post: post)
                                            if viewModel.isLastModel(post: post) && !viewModel.isCompleteLoading {
                                                ProgressView()
                                                    .onAppear {
                                                        viewModel.fetchMoreData()
                                                    }
                                            }
                                        }
                                    }
                                }
                                .gesture(
                                    DragGesture(minimumDistance: 1, coordinateSpace: .global)
                                        .onChanged { _ in
                                            isTextFieldFocused = false
                                        }
                                )
                            }
                            .refreshable {
                                viewModel.fetchInitialData()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
            .onChange(of: viewModel.searchText) { _ in viewModel.fetchInitialData()}
            .fullScreenCover(isPresented: $showSettings) {
                getRequestPermissionView()
            }
        }
    }

    private func getRequestPermissionView() -> AnyView {
        return AnyView(
            NavigationStack {
                RequestPermissionView(viewModel: RequestPermissionViewModel {
                    self.showSettings = false
                })
            }
            .transition(
                AnyTransition.move(edge: .bottom)
                .combined(with: .opacity)
                .animation(.easeInOut(duration: 0.3))
            )
        )
    }
}

struct HomeView_Previews: PreviewProvider {

    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
            .environmentObject(getNetWork())
    }

    static func getNetWork() -> NetworkMonitor {
        let network = NetworkMonitor()
        return network
    }
}
