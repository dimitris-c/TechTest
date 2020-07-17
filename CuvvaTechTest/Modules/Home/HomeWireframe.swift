//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

protocol HomeNavigable: class {
    func presentVehicleProfile(with id: String)
}

final class HomeWireframe: HomeNavigable {
    
    private let networking: Networking
    private let persistence: PolicyPersistence
    
    private var navigationController: UINavigationController?
    
    init(networking: Networking, persistence: PolicyPersistence) {
        self.networking = networking
        self.persistence = persistence
    }
    
    func prepareModule() -> UIViewController {
        
        let apiClient = PolicyAPIClient(networking: networking,
                                        baseUrl: PolicyAPIConfig.staging.baseUrl)
        
        let viewModel = HomeViewModel(apiClient: apiClient, policyPersistence: persistence, navigable: self)
        let homeController = HomeViewController(viewModel: viewModel)
        
        let navController = UINavigationController(rootViewController: homeController)
        self.navigationController = navController
        
        return navController
    }
    
    func presentVehicleProfile(with id: String) {
        
        let vehicleProfileWireframe = VehicleProfileWireframe(persistence: persistence, vehicleId: id)
        vehicleProfileWireframe.presentWireframe(on: self.navigationController)
        
    }
    
    
}
