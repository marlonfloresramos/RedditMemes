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
    @Published var isLoading: Bool = false
    @Published var isCompleteLoading: Bool = false
    var after: String? = nil
    var task: Task? = Task {}
    
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
            task?.cancel()
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
        task = Task {
            var response: RedditResponse?
            if searchText.count > 0 {
                do {
                    response = try await serviceManager.searchPosts(
                        search: searchText,
                        after: after)
                } catch(let error) {
                    print(error)
                }
            } else {
                do {
                    response = try await serviceManager.getPosts(
                        after: after)
                } catch(let error) {
                    print(error)
                }
            }
            let newPosts = response?.data?.children ?? [RedditPost]()
            let after = response?.data?.after
            let filteredPosts = newPosts.filter(
                { $0.data?.linkFlairText == "Shitposting" && $0.data?.postHint == "image" })
            DispatchQueue.main.async {
                self.after = after
                print(filteredPosts.count)
                print(self.after)
                if filteredPosts.count == 0 && after != nil {
                    self.fetchData()
                    print("recursive")
                } else {
                    self.posts.append(contentsOf: filteredPosts)
                    self.isLoading = false
                    if after == nil {
                        self.isCompleteLoading = true
                        print("completed")
                    }
                }
            }
        }
    }
}
