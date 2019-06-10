//
//  Repository.swift
//  SwiftUINetworking
//
//  Created by Kyle Blazier on 6/9/19.
//  Copyright © 2019 Kyle Blazier. All rights reserved.
//

import Foundation
import SwiftUI

public struct ItemsResponse<T: Decodable>: Decodable {
    let items: [T]
}

public struct Repository: Decodable, Identifiable {
    public let id: Int
    let fullName: String
    let description: String?
    let stargazersCount: Int
    let htmlUrl: URL

    #if DEBUG
    enum TestData {
        static let allFields = Repository(id: 0,
                                          fullName: "Test Repository Name",
                                          description: "Repository description. This is typically longer.",
                                          stargazersCount: 150,
                                          htmlUrl: URL(string: "https://google.com")!)
        
        static let multilineDescription = Repository(id: 1,
                                                    fullName: "Repository Name with a multiline description",
                                                    description: "The Swift code generator for your assets, storyboards, Localizable.strings, … — Get rid of all String-based APIs!",
                                                    stargazersCount: 123456789,
                                                    htmlUrl: URL(string: "https://google.com")!)
    }
    #endif
}
