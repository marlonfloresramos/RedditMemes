//
//  HomeViewModel.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    let serviceManager: APIClient
    @Published var posts = [RedditPost]()
    @Published var searchText = ""
    var after: String? = nil
    @Published var isLoading: Bool = false
    @Published var isCompleteLoading: Bool = false
    
    init(serviceManager: APIClient = APIClient.shared) {
        self.serviceManager = serviceManager
        fetchInitialData()
    }
    
    func isLastModel(post: RedditPost) -> Bool {
        return post.id == posts.last?.id
    }
    
    func fetchMoreData() {
        guard let _ = after else { return }
        guard !isLoading else { return }
        self.fetchData()
    }
    
    func fetchInitialData() {
        if isLoading {
//            serviceManager.cancelFetchData()
            print("cancel fetch")
        }
        
        posts.removeAll()
        after = nil
        isLoading = false
        isCompleteLoading = false
        fetchData()
    }
    
    func fetchData() {
        isLoading = true
        Task {
            var response: RedditResponse?
            if searchText.count > 0 {
                do {
                    response = try await serviceManager.searchPosts(
                        search: searchText,
                        after: after)
                } catch {
                    
                }
            } else {
                do {
                    response = try await serviceManager.getPosts(
                        after: after)
                } catch {
                    
                }
            }
            let newPosts = response?.data?.children ?? [RedditPost]()
            let after = response?.data?.after
            let filteredPosts = newPosts.filter(
                { $0.data?.linkFlairText == "Shitposting" && $0.data?.postHint == "image" })
            DispatchQueue.main.async {
                self.after = after
                self.posts.append(contentsOf: filteredPosts)
                self.isLoading = false
            }
        }
    }
}
