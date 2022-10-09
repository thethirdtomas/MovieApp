//
//  Request.swift
//  MovieBrowser
//
//  Created by Tomas Torres on 10/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

// All the API services used by the app
// Only one in this case
enum APIService {
    case theMovieDB
    
    var baseURL: String {
        switch self {
        case .theMovieDB:
            return "https://api.themoviedb.org/3"
        }
    }
    
    var apiKey: String {
        switch self {
        case .theMovieDB:
            return "5885c445eab51c7004916b9c0313e2d3"
        }
    }
}

enum Request {
    case searchMovies(with: String)
    
    private var service: APIService {
        switch self {
        case .searchMovies:
            return .theMovieDB
        }
    }
    
    private var method: URLRequest.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    private var path: String {
        var path: String
        switch self {
        case .searchMovies:
            path = "search/movie"
        }
        
        guard !params.isEmpty else { return path }
        
        let parameters = params.map { "\($0)=\($1)" }.joined(separator: "&")
        return [path, parameters].joined(separator: "?")
    }
    
    private var params: [String: String] {
        var params = [String: String]()
        switch self {
        case .searchMovies(let query):
            params["api_key"] = service.apiKey
            params["query"] = query.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        }
        
        return params
    }
    
    private var urlString: String {
        return [service.baseURL, path].joined(separator: "/")
    }
    
    var urlRequest: URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError("Unable to create url from \(urlString)")
        }
        
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
}


extension URLRequest {
    enum HTTPMethod: String, CaseIterable {
        case options = "OPTIONS"
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case trace = "TRACE"
        case connect = "CONNECT"
    }

    var method: HTTPMethod? {
        get {
            guard let httpMethod = httpMethod else { return nil }
            return HTTPMethod(rawValue: httpMethod)
        }
        set {
            httpMethod = newValue?.rawValue
        }
    }
}
