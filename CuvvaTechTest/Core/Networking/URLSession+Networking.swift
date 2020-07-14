//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum NetworkError: Error, Equatable {
    case unknown
    case nonHTTPResponse(response: URLResponse)
    case decodingFailed(message: String)
    case httpRequestFailed(response: HTTPURLResponse, data: Data?)
}

protocol NetworkingSession {
    func response(request: URLRequest, completion: @escaping (Result<(response: HTTPURLResponse, data: Data), Error>) -> Void)
}

extension URLSession: NetworkingSession {
    func response(request: URLRequest, completion: @escaping (Result<(response: HTTPURLResponse, data: Data), Error>) -> Void) {
        let task = self.dataTask(with: request) { (data, response, error) in
            guard let response = response, let data = data else {
                completion(.failure(error ?? NetworkError.unknown))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.nonHTTPResponse(response: response)))
                return
            }
            
            completion(.success((httpResponse, data)))
        }
        
        task.resume()
    }
}
