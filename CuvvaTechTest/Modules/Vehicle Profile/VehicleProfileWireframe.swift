//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

protocol VehicleProfileNavigable {
    func showReceipt()
}

final class VehicleProfileWireframe: VehicleProfileNavigable {
    
    private let persistence: PolicyPersistence
    private let vehicleId: String
    
    init(persistence: PolicyPersistence, vehicleId: String) {
        self.persistence = persistence
        self.vehicleId = vehicleId
    }
    
    func presentWireframe(on presentingController: UINavigationController?) {
        
        let viewModel = VehicleProfileViewModel(persistence: persistence, vehicleId: vehicleId, navigable: self)
        let viewController = VehicleProfileViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        
        presentingController?.present(navController, animated: true, completion: nil)
        
    }
 
    func showReceipt() {
        // TODO:
    }
}
