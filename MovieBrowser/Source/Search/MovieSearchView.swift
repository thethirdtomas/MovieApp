//
//  MovieSearchView.swift
//  MovieBrowser
//
//  Created by Tomas Torres on 10/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import SwiftUI

struct MovieSearchView: View {
    var body: some View {
        NavigationView {
            ZStack {
                ProgressView()
            }
            .navigationTitle("Movie Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
