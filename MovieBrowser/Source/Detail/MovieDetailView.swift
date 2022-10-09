//
//  MovieDetailView.swift
//  MovieBrowser
//
//  Created by Tomas Torres on 10/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text(viewModel.movie.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                if let formattedReleaseDate = viewModel.movie.formattedReleaseDate2 {
                    Text("Release Date: \(formattedReleaseDate)")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            HStack(alignment: .top, spacing: 15) {
                AsyncImage(url: viewModel.movie.posterURL) { image in
                    image
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image("placeholder")
                }
                
                Text(viewModel.movie.overview)
            }
            
            Spacer()
        }
        .padding()
    }
}
