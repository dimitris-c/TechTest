//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation
import RealmSwift

protocol PolicyPersistence {
    func store(policyData: PolicyData)
    
    func retrievePolicies() -> Results<Policy>
    func retrieveTransactions() -> Results<PolicyTransaction>

}

final class PolicyPersistenceService: PolicyPersistence {
    
    private let persistence: Persistence
    
    
    init(persistence: Persistence) {
        self.persistence = persistence
    }

    func store(policyData: PolicyData) {
        persistence.write { realm in
            for item in policyData.data {
                switch item.payload {
                    case .created(let value):
                        realm.add(value, update: .modified)
                    case .transaction(let value):
                        realm.add(value, update: .modified)
                    case .cancelled(let value):
                        realm.add(value, update: .modified)
                    case .unknown:
                        continue
                }
            }
        }
    }
    
    func retrieveTransactions() -> Results<PolicyTransaction> {
        self.persistence.retrieve(type: PolicyTransaction.self)
    }
    
    func retrievePolicies() -> Results<Policy> {
        self.persistence.retrieve(type: Policy.self)
    }
    
}
