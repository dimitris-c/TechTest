//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

struct PolicyData: Codable, Equatable {
    let data: [PolicyWrapper]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var data = [PolicyWrapper]()
        while !container.isAtEnd {
            let value = try container.decode(PolicyWrapper.self)
            data.append(value)
        }
        self.data = data
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for value in data {
            try container.encode(value)
        }
    }
    
    func policies() -> [Policy] {
        return data.compactMap { wrapper -> Policy? in
            wrapper.payload.policy
        }
    }
    
    func transactions() -> [PolicyTransaction] {
        return data.compactMap { wrapper -> PolicyTransaction? in
            wrapper.payload.transaction
        }
    }
    
    func cancelled() -> [PolicyCancelled] {
        return data.compactMap { wrapper -> PolicyCancelled? in
            wrapper.payload.cancelled
        }
    }
    
}
