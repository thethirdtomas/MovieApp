//
//  MovieSearchView.swift
//  MovieBrowser
//
//  Created by Tomas Torres on 10/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject var viewModel = MovieSearchViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TextField("Search movies", text: $viewModel.searchQuery)
                        .modifier(SearchFieldModifier(text: $viewModel.searchQuery))
                        .padding(10)
                    Spacer()
                }
                ProgressView()
            }
            .navigationTitle("Movie Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct SearchFieldModifier: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                )
            }
        }
        .padding(5)
        .background(Color(UIColor.opaqueSeparator).opacity(0.3))
        .cornerRadius(10)
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
