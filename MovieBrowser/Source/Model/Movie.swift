//
//  Movie.swift
//  MovieBrowser
//
//  Created by Tomas Torres on 10/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: UInt64
    let title: String
    let rating: Double
    let releaseDate: String?
    let overview: String
    let posterPath: String?
    
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case rating = "vote_average"
        case releaseDate = "release_date"
        case overview
        case posterPath = "poster_path"
    }
}

struct MovieSearchResponse: Decodable {
    let results: [Movie]
}


// MARK: - Display
extension Movie {
    var formattedReleaseDate1: String? {
        self.releaseDate?.toDate()?.getFormattedDate(format: "MMMM dd, yyyy")
    }
    
    var formattedReleaseDate2: String? {
        self.releaseDate?.toDate()?.getFormattedDate(format: "M/d/yy")
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") ?? nil
    }
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: self) {
            return date
        }
        return nil
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

