//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation
import RealmSwift

class Policy: Object, Codable {
    @objc dynamic var userId: String = ""
    @objc dynamic var userRevision: String = ""
    @objc dynamic var policyId: String = ""
    @objc dynamic var originalPolicyId: String = ""
    @objc dynamic var referenceCode: String = ""
    @objc dynamic var startDate: Date?
    @objc dynamic var endDate: Date?
    @objc dynamic var incidentPhone: String = ""
    @objc dynamic var vehicle: Vehicle? = nil
    @objc dynamic var documents: Documents? = nil
    
    @objc dynamic var cancelled: PolicyCancelled? = nil
    
    let transactions = List<PolicyTransaction>()
    let extensionPolicies = List<Policy>()
    
    var isExtensionPolicy: Bool {
        return policyId != originalPolicyId
    }
    
}

extension Policy {
    func isActive() -> Bool {
        guard let startDate = self.startDate else { return false }
        let latestExtensionPolicy = extensionPolicies.first { policy -> Bool in
            guard policy.cancelled == nil else { return false }
            guard let endDate = self.endDate, let policyEndDate = policy.endDate else {
                return false
            }
            return policyEndDate > endDate
        }
        guard let latestExtensionPolicyEndDate = latestExtensionPolicy?.endDate ?? self.endDate else {
            return false
        }
        let now = Date()
        return (startDate...latestExtensionPolicyEndDate).contains(now)
    }
}

class Documents: Object, Codable {
    @objc dynamic var certificateUrl: String = ""
    @objc dynamic var termsUrl: String = ""
}

class Vehicle: Object, Codable {
    @objc dynamic var vrm: String = ""
    @objc dynamic var prettyVrm: String = ""
    @objc dynamic var make: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var variant: String? = nil
    @objc dynamic var color: String = ""
}
