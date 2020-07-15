//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

@testable import CuvvaTechTest

class PolicyMockData {
    static var jsonData: Data {
        jsonTestData.data(using: .utf8)!
    }
    
    static var jsonEmptyPayloadData: Data {
        jsonTestDataEmptyPayload.data(using: .utf8)!
    }
}

func convertDataToPolicyData(from data: Data) -> PolicyData? {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.iso8601)
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    return try? decoder.decode(PolicyData.self, from: data)
}
