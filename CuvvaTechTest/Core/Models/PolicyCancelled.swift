//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

struct PolicyCancelled: Decodable, Equatable {
    let policyId: String
    let type: String
    let newEndDate: Date?
}
