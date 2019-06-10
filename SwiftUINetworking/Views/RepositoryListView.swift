//
//  RepositoryListView.swift
//  SwiftUINetworking
//
//  Created by Kyle Blazier on 6/9/19.
//  Copyright © 2019 Kyle Blazier. All rights reserved.
//

import SwiftUI

struct RepositoryListView : View {
    @EnvironmentObject private var viewModel: RepositoriesViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView { searchText in
                    self.viewModel.search(query: searchText)
                }
                List {
                    ForEach(viewModel.repositories) { repo in
                        RepositoryView(repository: repo)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct RepositoryListView_Previews : PreviewProvider {
    static var previews: some View {
        RepositoryListView()
            .environmentObject(RepositoriesViewModel.testData)
    }
}
#endif
