//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum PolicyType: Decodable, Equatable {
    case created(Policy)
    case transaction(PolicyTransaction)
    case cancelled(PolicyCancelled)
    case unknown
    
    enum PolicyCodingKeys: String, CodingKey {
        case created = "policy_created"
        case transaction = "policy_financial_transaction"
        case cancelled = "policy_cancelled"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PolicyWrapper.CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        if type == PolicyCodingKeys.created.rawValue {
            let policy = try container.decode(Policy.self, forKey: .payload)
            self = .created(policy)
        }
        else if type == PolicyCodingKeys.transaction.rawValue {
            let transaction = try container.decode(PolicyTransaction.self, forKey: .payload)
            self = .transaction(transaction)
        }
        else if type == PolicyCodingKeys.cancelled.rawValue {
            let policyCancelled = try container.decode(PolicyCancelled.self, forKey: .payload)
            self = .cancelled(policyCancelled)
        }
        else {
            self = .unknown
        }
    }
}
