//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation
import RealmSwift

protocol PolicyPersistence {
    func store(policyData: PolicyData)
    
    func retrieveVehicles() -> Results<Vehicle>
    
    func retrievePolicies() -> Results<Policy>
    
}

final class PolicyPersistenceService: PolicyPersistence {
    
    private let persistence: Persistence
    
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    func store(policyData: PolicyData) {
        self.persistence.write { realm in
            let processedPolicies = self.process(policyData: policyData)
            realm.add(processedPolicies, update: .modified)
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
            policy.vehicle?.policy = policy
        }
        return policies
    }
    
    func retrievePolicies() -> Results<Policy> {
        persistence.retrieve(type: Policy.self)
    }
    
    func retrieveVehicles() -> Results<Vehicle> {
        persistence.retrieve(type: Vehicle.self)
    }
    
}
