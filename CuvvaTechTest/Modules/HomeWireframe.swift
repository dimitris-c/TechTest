//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

final class HomeWireframe {
    
    private let networking: Networking
    private let persistence: Persistence
    
    private var navigationController: UINavigationController?
    
    init(networking: Networking, persistence: Persistence) {
        self.networking = networking
        self.persistence = persistence
    }
    
    func prepareModule() -> UIViewController {
        
        let policyPersistence = PolicyPersistenceService(persistence: persistence)
        let apiClient = PolicyAPIClient(networking: networking,
                                        baseUrl: PolicyAPIConfig.staging.baseUrl)
        
        let viewModel = HomeViewModel(apiClient: apiClient, policyPersistence: policyPersistence)
        let homeController = HomeViewController(viewModel: viewModel)
        
        let navController = UINavigationController(rootViewController: homeController)
        self.navigationController = navController
        
        return navController
    }
}
