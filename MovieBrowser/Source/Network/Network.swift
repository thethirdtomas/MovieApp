//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case unableToComplete
}

class Network {
    static let shared = Network()
    
    private init() {}
    
    func send<T: Decodable>(_ request: Request) async -> Result<T, NetworkError> {
        
        guard let (data, response) = try? await URLSession.shared.data(for: request.urlRequest) else {
            return .failure(.unableToComplete)
        }
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        
        guard (200..<300).contains(statusCode) else {
            return .failure(.invalidRequest)
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            return .failure(.invalidResponse)
        }
        
        return .success(result)
    }
}
