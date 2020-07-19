//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum VehicleProfileSectionModel: Equatable {
    case activePolicies(title: String, items: [VehicleProfileSectionItem])
    case previousPolicies(title: String, items: [VehicleProfileSectionItem])
}

enum VehicleProfileSectionItem: Equatable {
    case activePolicy(item: ActivePolicyDisplayModel)
    case previousPolicy(item: PreviousPolicyDisplayModel)
}

extension VehicleProfileSectionModel: SectionModelType {
    var items: [VehicleProfileSectionItem] {
        switch self {
            case .activePolicies(_, let items):
                return items
            case .previousPolicies(_, let items):
                return items
        }
    }
    
    var title: String {
        switch self {
            case .activePolicies(let title, _):
                return title
            case .previousPolicies(let title, _):
                return title
        }
    }
    
    init(section: VehicleProfileSectionModel, items: [VehicleProfileSectionItem]) {
        switch section {
            case .activePolicies(let title, _):
                self = .activePolicies(title: title, items: items)
            case .previousPolicies(let title, _):
                self = .previousPolicies(title: title, items: items)
        }
    }
}
