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
    @objc dynamic var documents: Decuments? = nil
    
    override class func primaryKey() -> String? {
        return "policyId"
    }
    
    var isExtensionPolicy: Bool {
        return policyId != originalPolicyId
    }
    
    var isActive: Bool {
        guard let startDate = startDate, let endDate = endDate else {
            return false
        }
        let now = Date()
        return (startDate...endDate).contains(now)
    }
}

class Decuments: Object, Codable {
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
