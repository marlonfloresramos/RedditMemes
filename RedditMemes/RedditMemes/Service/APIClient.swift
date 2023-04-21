//
//  APIClient.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import Foundation
import SwiftUI

enum MethodType: String {
    case GET
    case POST
}

protocol EndpointRepresentable {
    var scheme: String { get }
    var host: String { get }
    var methodType: MethodType { get }
    var path: String { get }
    var queryItems: [String: String]? { get }
}

enum RedditEndpoint: EndpointRepresentable {
    case getPosts(after: String?)
    case searchPosts(search: String, after: String?)

    var scheme: String {
        return "https"
    }

    var host: String {
        switch self {
        case .getPosts, .searchPosts:
            return "www.reddit.com"
        }

    }

    var methodType: MethodType {
        switch self {
        case .getPosts, .searchPosts:
            return .GET
        }
    }

    var path: String {
        switch self {
        case .getPosts:
            return "/r/chile/new/.json"
        case .searchPosts:
            return "/r/chile/search.json"
        }
    }

    var queryItems: [String: String]? {
        switch self {
        case .getPosts(let after):
            var query = ["limit": "100"]

            if let after {
                query["after"] = after
            }

            return query
        case .searchPosts(let search, let after):
            var query = ["limit": "100", "q": search]

            if let after {
                query["after"] = after
            }

            return query
        }
    }
}

final class APIClient {
    
    static let shared = APIClient()
    
    private init() {
    }

    func apiRequest<T: Codable>(_ type: T.Type, urlRequest: URLRequest) async throws -> T? {
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw URLError(.cannotDecodeRawData)
        }
    }

    func urlRequestBuilder(endPoint: EndpointRepresentable) -> URLRequest? {
        var components = URLComponents()
        components.scheme = endPoint.scheme
        components.host = endPoint.host
        components.path = endPoint.path
        if let queryItems = endPoint.queryItems {
            components.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
        }
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 5
        urlRequest.httpMethod = endPoint.methodType.rawValue
        return urlRequest
    }

    func getPosts(after: String?) async throws -> RedditResponse? {
        guard let urlRequest = urlRequestBuilder(endPoint: RedditEndpoint.getPosts(after: after)) else { throw URLError(.fileDoesNotExist) }

        do {
            let model = try await apiRequest(RedditResponse.self, urlRequest: urlRequest)
            return model
        } catch let error {
            throw error
        }
    }
    
    func searchPosts(search: String, after: String?) async throws -> RedditResponse? {
        guard let urlRequest = urlRequestBuilder(endPoint: RedditEndpoint.searchPosts(search: search, after: after)) else { throw URLError(.fileDoesNotExist) }

        do {
            let model = try await apiRequest(RedditResponse.self, urlRequest: urlRequest)
            return model
        } catch let error {
            throw error
        }
    }
}
