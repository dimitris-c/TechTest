//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum PolicyType: Codable, Equatable {
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .created(let policy):
                try container.encode(policy)
            case .transaction(let transaction):
                try container.encode(transaction)
            case .cancelled(let cancelled):
                try container.encode(cancelled)
            default:
            break
        }
    }
}

extension PolicyType {
    
    var policy: Policy? {
        if case let .created(policy) = self {
            return policy
        }
        return nil
    }
    
    var transaction: PolicyTransaction? {
        if case let .transaction(transaction) = self {
            return transaction
        }
        return nil
    }
    
    var cancelled: PolicyCancelled? {
        if case let .cancelled(cancelled) = self {
            return cancelled
        }
        return nil
    }
    
}
