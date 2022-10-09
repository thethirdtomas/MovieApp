//
//  MovieSearchViewModel.swift
//  MovieBrowser
//
//  Created by Tomas Torres on 10/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class MovieSearchViewModel: ObservableObject {
    enum LoadingState {
        case none
        case loading
        case empty
        case loaded
        case failed
    }
    
    @Published var loadingState: LoadingState = .none
    @Published private(set) var movies: [Movie] = []
    @Published var searchQuery = "" {
        didSet {
            if searchQuery.isEmpty {
                movies.removeAll()
                loadingState = .none
            }
        }
    }
    
    var movieSearchTask: Task<(), Never>? = nil
}

// MARK: - Network
extension MovieSearchViewModel {
    func searchMovies(with query: String) {
        if query.isEmpty {
            return
        }
        self.loadingState = .loading
        if let task = self.movieSearchTask {
            task.cancel()
        }
        
        self.movieSearchTask = Task {
            let response: Result<MovieSearchResponse, NetworkError> = await Network.shared.send(.searchMovies(with: query))
            
            await MainActor.run {
                switch response {
                case .success(let searchResponse):
                    self.movies = searchResponse.results.compactMap {$0}
                    if self.movies.isEmpty {
                        self.loadingState = .empty
                    } else {
                        self.loadingState = .loaded
                    }
                    
                case .failure(let error):
                    self.movies.removeAll()
                    self.loadingState = .failed
                    print(error)
                }
            }
        }
    }
}
