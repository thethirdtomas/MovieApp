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


extension DateFormatter {
  static let ymd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

extension String {
    func toDate() -> Date? {
        if let date = DateFormatter.ymd.date(from: self) {
            return date
        }
        return nil
    }
}
