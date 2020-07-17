//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum VehicleProfileViewAction {
    case viewLoaded
}

enum VehicleProfileViewEffect {
    case loading
    case loaded
    case error(title: String, message: String)
}

protocol VehicleProfileViewModelType {
    var dataSource: VehicleProfileModelDataSource { get }
    
    // Inputs
    func perform(action: VehicleProfileViewAction)
    
    // Outputs
    var updateContent: ((VehicleProfileViewEffect) -> Void)? { get set }
    
}

final class VehicleProfileViewModel: VehicleProfileViewModelType {
    let dataSource = VehicleProfileModelDataSource()
    
    private let vehicleId: String
    private let policyPersistence: PolicyPersistence
    
    private let navigable: VehicleProfileNavigable
    
    var updateContent: ((VehicleProfileViewEffect) -> Void)?
    
    init(persistence: PolicyPersistence, vehicleId: String, navigable: VehicleProfileNavigable) {
        self.policyPersistence = persistence
        self.vehicleId = vehicleId
        self.navigable = navigable
    }

    func perform(action: VehicleProfileViewAction) {
        switch action {
            case .viewLoaded:
                viewLoadedAction()
        }
    }
    
    private func viewLoadedAction() {
        
    }

}
