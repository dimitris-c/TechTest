//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

struct Policy: Codable, Equatable {
    let userId: String
    let userRevision: String
    let policyId: String
    let originalPolicyId: String
    let referenceCode: String
    let startDate: Date
    let endDate: Date
    let incidentPhone: String
    let vehicle: Vehicle
    let documents: Decuments
}

struct Decuments: Codable, Equatable {
    let certificateUrl: String
    let termsUrl: String
}

struct Vehicle: Codable, Equatable {
    let vrm: String
    let prettyVrm: String
    let make: String
    let model: String
    let variant: String?
    let color: String
}
