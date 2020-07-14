//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

struct PolicyData: Decodable, Equatable {
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
    
    func policies() -> [Policy] {
        return data.compactMap { wrapper -> Policy? in
            if case let .created(policy) = wrapper.payload {
                return policy
            }
            return nil
        }
    }
    
    func transactions() -> [PolicyTransaction] {
        return data.compactMap { wrapper -> PolicyTransaction? in
            if case let .transaction(transaction) = wrapper.payload {
                return transaction
            }
            return nil
        }
    }
    
    func cancelled() -> [PolicyCancelled] {
        return data.compactMap { wrapper -> PolicyCancelled? in
            if case let .cancelled(policy) = wrapper.payload {
                return policy
            }
            return nil
        }
    }
    
}
