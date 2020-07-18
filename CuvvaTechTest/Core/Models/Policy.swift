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
    
    override class func primaryKey() -> String? {
        return "policyId"
    }
    
    let transactions = List<PolicyTransaction>()
    let extensionPolicies = List<Policy>()
    
    var isExtensionPolicy: Bool {
        return policyId != originalPolicyId
    }
    
    var isVoided: Bool {
        return cancelled != nil
    }
    
}

extension Policy {
    func isActive() -> Bool {
        guard let startDate = self.startDate, let endDate = self.endDate, endDate > Date() else { return false }
        let latestExtensionPolicy = extensionPolicies.last { extPolicy -> Bool in
            guard extPolicy.cancelled == nil else { return false }
            guard let extPolicyEndDate = extPolicy.endDate, extPolicyEndDate > Date() else {
                return false
            }
            return extPolicyEndDate > endDate
        }
        let now = Date()
        if let latestExtensionPolicyEndDate = latestExtensionPolicy?.endDate {
            return (startDate...latestExtensionPolicyEndDate).contains(now)
        }
        return (startDate...endDate).contains(now)
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
    
    var policies: LazyFilterSequence<Results<Policy>>? {
        return realm?.objects(Policy.self).filter { $0.vehicle?.vrm == self.vrm }
    }
    
    enum CodingKeys: String, CodingKey {
        case vrm
        case prettyVrm
        case make
        case model
        case variant
        case color
    }
    
    var totalPolicies: Int {
        return policies?.count ?? 0
    }
    
    override class func primaryKey() -> String? {
        return "vrm"
    }
}
