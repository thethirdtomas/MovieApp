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
                        .padding(.horizontal, 8)
                        .padding(.top, 10)
                        .onReceive(
                            viewModel.$searchQuery
                               .debounce(for: .seconds(0.4), scheduler: DispatchQueue.main)
                        ) {
                            viewModel.searchMovies(with: $0)
                        }
                    
                    List(viewModel.movies) { movie in
                        movieRowLink(movie: movie)
                    }
                    .listStyle(.plain)
                }
                
                switch viewModel.loadingState {
                case .none:
                    VStack {
                        Text("Movie Browser")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Search for the movies you love")
                    }
                case .loading:
                    ProgressView()
                    
                case .empty:
                    Text("No movie results")
                        .font(.title3)
                        .fontWeight(.bold)
                case .failed:
                    Text("Oops. Something went wrong...")
                        .font(.title3)
                        .fontWeight(.bold)
                case .loaded:
                    EmptyView()
                }
            }
            .navigationTitle("Movie Search")
            .navigationBarTitleDisplayMode(.inline)
            .onDisappear {
                if let searchTask = viewModel.movieSearchTask {
                    searchTask.cancel()
                }
            }
        }
    }
    
    func movieRowLink(movie: Movie) -> some View {
        NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movie: movie))) {
            HStack {
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title)
                        .lineLimit(2)
                    Spacer()
                    if let releaseDate = movie.formattedReleaseDate1 {
                        Text(releaseDate)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                Text(String(format: "%.1f", movie.rating))
            }
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
