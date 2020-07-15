//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation
import RealmSwift

class PolicyCancelled: Object, Codable {
    @objc dynamic var policyId: String = ""
    @objc dynamic var type: String = ""
    // Realm doesn't support variables names that start with `new`
    @objc dynamic var endDate: Date? = nil
    
    override class func primaryKey() -> String? {
        return "policyId"
    }
    
    enum PolicyCancelledKeys: String, CodingKey {
        case policyId
        case type
        case newEndDate
    }
}
