//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

struct PolicyWrapper: Decodable, Equatable {
    let type: String
    let timestamp: Date
    let uniqueKey: String
    let payload: PolicyType
    
    enum CodingKeys: String, CodingKey {
        case type
        case timestamp
        case uniqueKey
        case payload
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.uniqueKey = try container.decode(String.self, forKey: .uniqueKey)
        self.payload = try PolicyType(from: decoder)
    }
}
