//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

struct VehicleDisplayModel: Equatable {
    let carMakeTitle: String
    let carMakeSubtitle: String
    let carMakeLogo: UIImage?
    
    let regPlateTitle: String = "Reg Plate"
    let regPlateValueTitle: String
    
    var totalPoliciesTitle: String = "Total Policies"
    let totalPoliciesValueTitle: String
    
    init(vehicle: Vehicle, totalPolicies: Int) {
        self.carMakeTitle = vehicle.make
        self.carMakeSubtitle = "\(vehicle.color) \(vehicle.model)"
        self.carMakeLogo = UIImage(named: "\(vehicle.make.lowercased())-logo")
        self.regPlateValueTitle = vehicle.prettyVrm
        
        self.totalPoliciesValueTitle = String(totalPolicies)
    }
    
}

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
