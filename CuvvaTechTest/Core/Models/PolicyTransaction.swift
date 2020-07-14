//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation


struct PolicyTransaction: Decodable, Equatable {
    let policyId: String
    let pricing: Receipt
}

struct Receipt: Decodable, Equatable {
    let underwriterPremium: Int
    let commission: Int
    let totalPremium: Int
    let ipt: Int
    let iptRate: Int
    let extraFees: Int
    let vat: Int
    let deductions: Int
    let totalPayable: Int
}

