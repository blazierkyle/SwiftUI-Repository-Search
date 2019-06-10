//
//  RepositoriesViewModel.swift
//  SwiftUINetworking
//
//  Created by Kyle Blazier on 6/9/19.
//  Copyright © 2019 Kyle Blazier. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class RepositoriesViewModel : BindableObject {
    
    // MARK: - Properties
    
    let didChange = PassthroughSubject<RepositoriesViewModel, Never>()
    
    /// A private `PassthroughSubject` used to perform search queries.
    private let searchWithQuery = PassthroughSubject<String, Never>()
    
    /// Update the value of  `repositories` as a result of the Publisher sending us a message.
    private lazy var updateRepositories = Subscribers.Assign(object: self, keyPath: \.repositories)

    private(set) var repositories: [Repository] = [] {
        didSet {
            // TODO: When the below search callback can use the main thread operator, we won't need this
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
        }
    }
    
    // MARK: - Initializers
    
    init(api: APIService) {
        searchWithQuery
            .flatMap { query -> AnyPublisher<[Repository], Never> in
                api.getRepositories(with: query)
                    .replaceError(with: [])
                    .eraseToAnyPublisher()
            }
            .receive(subscriber: updateRepositories)
        
        // TODO: Ideally, we should be able to use the `.receive(on: RunLoop.main)`
        //  operator but that doesn't seem to be implemented yet (it was in WWDC videos)
    }
    
    #if DEBUG
    /// An initializer that takes an array of repositories, for previews and testing purposes.
    init(repositories: [Repository]) {
        self.repositories = repositories
    }
    #endif
    
    // MARK: - Searching
    
    func search(query: String) {
        searchWithQuery.send(query)
    }
    
    // MARK: - Test Data
    
    #if DEBUG
    static let testData = RepositoriesViewModel(repositories: [Repository.TestData.multilineDescription])
    #endif
}
