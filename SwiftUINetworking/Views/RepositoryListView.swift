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
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            TextField($searchText,
                      placeholder: Text("Search Repositories...")) {
                        self.viewModel.search(query: self.searchText)
            }
                .frame(height: 40)
                .padding(EdgeInsets(top: 0,
                                    leading: 8,
                                    bottom: 0,
                                    trailing: 8))
                .border(Color.gray, cornerRadius: 8)
                .padding(EdgeInsets(top: 0,
                                    leading: 16,
                                    bottom: 0,
                                    trailing: 16))
            
            List {
                ForEach(viewModel.repositories) { repo in
                    RepositoryView(repository: repo)
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
