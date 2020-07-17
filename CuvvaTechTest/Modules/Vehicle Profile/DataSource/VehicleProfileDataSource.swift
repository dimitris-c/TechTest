//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

struct PreviousPolicyDisplayModel {
    
}

enum VehicleProfileSectionModel {
    case activePolicies(title: String, items: [VehicleProfileSectionItem])
    case previousPolicies(title: String, items: [VehicleProfileSectionItem])
}

enum VehicleProfileSectionItem {
    case activePolicy(item: ActivePolicyDisplayModel)
    case previousPolicy(item: PreviousPolicyDisplayModel)
}

extension VehicleProfileSectionModel {
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
}


final class VehicleProfileModelDataSource {
    
    private(set) var data: [VehicleProfileSectionModel] = []
    
    func sectionModel(at index: Int) -> VehicleProfileSectionModel? {
        return data[index]
    }
    
    func model(at indexPath: IndexPath) -> VehicleProfileSectionItem? {
        return data[indexPath.section].items[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return data.count
    }
    
    func numberOfItems(for section: Int) -> Int {
        guard let sectionModel = sectionModel(at: section) else { return 0 }
        return sectionModel.items.count
    }
    
    func update(data: [VehicleProfileSectionModel]) {
        self.data = data
    }
    
}
