//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation
import RealmSwift

class PolicyTransaction: Object, Codable {
    @objc dynamic var date: Date?
    @objc dynamic var policyId: String = ""
    @objc dynamic var pricing: Receipt? = nil
    
    override class func primaryKey() -> String? {
        return "policyId"
    }
    
}

class Receipt: Object, Codable {
    @objc dynamic var underwriterPremium: Int = 0
    @objc dynamic var commission: Int = 0
    @objc dynamic var totalPremium: Int = 0
    @objc dynamic var ipt: Int = 0
    @objc dynamic var iptRate: Int = 0
    @objc dynamic var extraFees: Int = 0
    @objc dynamic var vat: Int = 0
    @objc dynamic var deductions: Int = 0
    @objc dynamic var totalPayable: Int = 0
}

