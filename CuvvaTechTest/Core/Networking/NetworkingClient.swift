//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

typealias NetworkCompletion<Response> = (Result<(response: HTTPURLResponse, result: Response), Error>) -> Void
protocol Networking {
    func request<Response>(_ endpoint: Endpoint<Response>, baseURL: URL, completion: @escaping NetworkCompletion<Response>)
}

final class NetworkingClient: Networking {
    
    private let session: NetworkingSession
    
    init(session: NetworkingSession = URLSession.shared) {
        self.session = session
    }
    
    func request<Response>(_ endpoint: Endpoint<Response>, baseURL: URL, completion: @escaping NetworkCompletion<Response>) {
        let request = self.buildRequest(endpoint: endpoint, baseURL: baseURL)
        
        self.session.response(request: request) { result in
            switch result {
            case .success(let value):
                do {
                    let result = try endpoint.decode(value.data)
                    completion(.success((value.response, result)))
                } catch {
                    completion(.failure(NetworkError.decodingFailed(message: error.localizedDescription)))
                }
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
        
    }
    
    // MARK: Private
    
    private func buildRequest<Response>(endpoint: Endpoint<Response>, baseURL: URL) -> URLRequest {
        let url = self.url(from: endpoint.path, baseURL: baseURL)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.cachePolicy = endpoint.cachePolicy

        return request
    }
    
    private func url(from path: Path, baseURL: URL) -> URL {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return baseURL.appendingPathComponent(path)
        }
        urlComponents.path = path
        
        return urlComponents.url ?? baseURL
    }
}
