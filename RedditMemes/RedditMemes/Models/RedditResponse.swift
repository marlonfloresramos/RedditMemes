//
//  RedditResponse.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import Foundation

class RedditResponse: Codable {
    let data: RedditData?
}

class RedditData: Codable {
    let after: String?
    let before: String?
    let children: [RedditPost]?
}

class RedditPost: Codable, Identifiable {
    var id = UUID()
    let data: PostData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

class PostData: Codable {
    let title: String?
    let score: Int?
    let numberOfComments: Int?
    let linkFlairText: String?
    let postHint: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case score
        case numberOfComments = "num_comments"
        case linkFlairText = "link_flair_text"
        case postHint = "post_hint"
        case url
    }
}
