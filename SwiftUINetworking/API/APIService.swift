//
//  APIService.swift
//  SwiftUINetworking
//
//  Created by Kyle Blazier on 6/9/19.
//  Copyright © 2019 Kyle Blazier. All rights reserved.
//

import Foundation
import Combine

struct APIService {
    private static let repositoriesSearchURL = "https://api.github.com/search/repositories"
    private static let repositoriesDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getRepositories(with query: String) -> AnyPublisher<[Repository], Error> {
        guard var components = URLComponents(string: APIService.repositoriesSearchURL) else {
            return Publishers.Empty<[Repository], Error>().eraseToAnyPublisher()
        }
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        
        guard let url = components.url else {
            return Publishers.Empty<[Repository], Error>().eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.send(request: request)
                .decode(type: ItemsResponse<Repository>.self, decoder: APIService.repositoriesDecoder)
                .map {
                    $0.items
                }
                .eraseToAnyPublisher()
    }
}

extension JSONDecoder: TopLevelDecoder { }
