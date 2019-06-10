//
//  SearchBarView.swift
//  SwiftUINetworking
//
//  Created by Kyle Blazier on 6/9/19.
//  Copyright © 2019 Kyle Blazier. All rights reserved.
//

import SwiftUI
import Combine

struct SearchBarView : View {
    @State var searchText = ""
  
    /// A callback for when changes have been committed to the textfield.
    ///     Parameter:` TextField`'s `text`
    let didCommitChanges: (String) -> Void
    
    var body: some View {
        TextField($searchText,
                  placeholder: Text("Search Repositories...")) {
                self.didCommitChanges(self.searchText)
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
    }
}

#if DEBUG
struct SearchBarView_Previews : PreviewProvider {
    static var previews: some View {
        SearchBarView(didCommitChanges: { _ in })
    }
}
#endif
