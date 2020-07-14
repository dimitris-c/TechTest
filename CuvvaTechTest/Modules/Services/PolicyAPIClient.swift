//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

protocol PolicyAPI {
    func getData(on queue: DispatchQueue, completion: @escaping (Result<PolicyData, NetworkError>) -> Void)
}

final class PolicyAPIClient: PolicyAPI {
    
    private let networking: Networking
    private let baseUrl: URL
    
    init(networking: Networking, baseUrl: URL) {
        self.networking = networking
        self.baseUrl = baseUrl
    }
    
    func getData(on queue: DispatchQueue = .main, completion: @escaping (Result<PolicyData, NetworkError>) -> Void) {
        let endpoint = Endpoint<PolicyData>(method: .get, path: "", parameters: nil, decode: policyDataDecoding, cachePolicy: .useProtocolCachePolicy)
        self.networking.request(endpoint, baseURL: baseUrl) { result in
            queue.async {
                switch result {
                    case .success(let respose):
                        completion(.success(respose.result))
                    case .failure(let error):
                        if let error = error as? NetworkError {
                            completion(.failure(error))
                        } else {
                            completion(.failure(NetworkError.error(message: error.localizedDescription)))
                    }
                }
            }
        }
    }
    
    private func policyDataDecoding(_ data: Data) throws -> PolicyData {
        let decode = JSONDecoder()
        decode.dateDecodingStrategy = .formatted(.iso8601)
        decode.keyDecodingStrategy = .convertFromSnakeCase
        return try decode.decode(PolicyData.self, from: data)
    }
    
}
