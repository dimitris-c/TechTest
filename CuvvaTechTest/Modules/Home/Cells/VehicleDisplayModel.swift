//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
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
    
    let vehicleId: String
    
    init(vehicle: Vehicle, totalPolicies: Int) {
        self.vehicleId = vehicle.vrm
        self.carMakeTitle = vehicle.make
        self.carMakeSubtitle = "\(vehicle.color) \(vehicle.model)"
        self.carMakeLogo = UIImage(named: "\(vehicle.make.lowercased())-logo")
        self.regPlateValueTitle = vehicle.prettyVrm
        
        self.totalPoliciesValueTitle = String(totalPolicies)
    }
    
}
