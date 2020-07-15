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
    
    let dispatchQueue = DispatchQueue(label: "persistence.queue", qos: .background)
    
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    func store(policyData: PolicyData) {
        dispatchQueue.async { [weak self] in
            guard let self = self else { return }
            self.persistence.write { realm in
                let processedPolicies = self.process(policyData: policyData)
                realm.add(processedPolicies, update: .error)
            }
        }
    }
    
    private func process(policyData: PolicyData) -> [Policy] {
        let policies = policyData.policies()
        let transactions = policyData.transactions()
        let cancelled = policyData.cancelled()
        for policy in policies {
            let transactions = transactions.filter { $0.policyId == policy.policyId }
            policy.transactions.append(objectsIn: transactions)
            let extensionPolicies = policies.filter { $0.originalPolicyId == policy.originalPolicyId && $0.isExtensionPolicy }
            policy.extensionPolicies.append(objectsIn: extensionPolicies)
            let cancelledPolicies = cancelled.first { $0.policyId == policy.policyId }
            policy.cancelled = cancelledPolicies
        }
        return policies
    }
    
    func retrieveTransactions() -> Results<PolicyTransaction> {
        self.persistence.retrieve(type: PolicyTransaction.self)
    }
    
    func retrievePolicies() -> Results<Policy> {
        self.persistence.retrieve(type: Policy.self)
    }
    
}
