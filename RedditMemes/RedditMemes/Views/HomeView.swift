//
//  HomeView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
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
            }
        }
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText) { _ in viewModel.fetchInitialData()}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
