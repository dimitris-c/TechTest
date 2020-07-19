//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

protocol VehicleProfileNavigable {
    func showReceipt(policyId: String)
    func closeVehicleProfile()
}

final class VehicleProfileWireframe: VehicleProfileNavigable {
    
    private let persistence: PolicyPersistence
    private let vehicleId: String
    
    private var navigationControler: UINavigationController?
    private var presentingController: UINavigationController?
    
    init(persistence: PolicyPersistence, vehicleId: String) {
        self.persistence = persistence
        self.vehicleId = vehicleId
    }
    
    func presentWireframe(on presentingController: UINavigationController?) {
        
        let viewModel = VehicleProfileViewModel(persistence: persistence, vehicleId: vehicleId, navigable: self)
        let viewController = VehicleProfileViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        
        self.navigationControler = navController
        self.presentingController = presentingController
        presentingController?.present(navController, animated: true, completion: nil)
        
    }
    
    func showReceipt(policyId: String) {
        let viewModel = TransactionViewModel(policyPersistence: persistence, policyId: policyId)
        let viewController = TransactionViewController(viewModel: viewModel)
        
        self.navigationControler?.pushViewController(viewController, animated: true)
    }
    
    func closeVehicleProfile() {
        self.presentingController?.dismiss(animated: true, completion: { [weak self] in
            self?.navigationControler = nil
        })
    }
}
