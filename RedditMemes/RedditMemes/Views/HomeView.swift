//
//  HomeView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(CustomColor.searchText)
            TextField("Search", text: $viewModel.searchText)
                .font(Font.system(size: 16))
                .foregroundColor(CustomColor.searchText)
        }
        .padding(10)
        .background(CustomColor.searchBackground)
        .cornerRadius(4)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                searchBar
                if viewModel.noResults {
                    NoResultsView()
                } else {
                    ScrollView {
                        LazyVStack {
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
                    }
                    .scrollIndicators(.hidden)
                    .refreshable {
                        viewModel.fetchInitialData()
                    }
                }
            }
            .padding(.horizontal, 20)

        }
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        .onChange(of: viewModel.searchText) { _ in viewModel.fetchInitialData()}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
