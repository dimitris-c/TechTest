//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

enum HomeSectionModel: Equatable {
    case active(title: String, items: [HomeSectionItem])
    case vehicles(title: String, items: [HomeSectionItem])
}

extension HomeSectionModel {
    var items: [HomeSectionItem] {
        switch self {
            case .active(_, let items):
                return items
            case .vehicles(_, let items):
                return items
        }
    }
    
    var title: String {
        switch self {
            case .active(let title, _):
                return title
            case .vehicles(let title, _):
                return title
        }
    }
}

enum HomeSectionItem: Equatable {
    case activeItem(item: ActivePolicyDisplayModel)
    case vehicle(item: VehicleDisplayModel)
}
