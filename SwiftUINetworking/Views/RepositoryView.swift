//
//  RepositoryView.swift
//  SwiftUINetworking
//
//  Created by Kyle Blazier on 6/9/19.
//  Copyright © 2019 Kyle Blazier. All rights reserved.
//

import SwiftUI

struct RepositoryView : View {
    var repository: Repository
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "doc.text")
                Text(repository.fullName)
                    .lineLimit(nil)
                    .font(.title)
            }
            
            repository.description
                .map(Text.init)?
                .lineLimit(nil)
            
            HStack {
                Image(systemName: "star")
                Text("\(repository.stargazersCount)")
            }
        }
    }
}

#if DEBUG
struct RepositoryView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            RepositoryView(repository: Repository.TestData.allFields)
            RepositoryView(repository: Repository.TestData.multilineDescription)
        }
    }
}
#endif
