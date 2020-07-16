//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum HomeViewAction {
    case viewLoaded
    case reload
}

enum HomeViewEffect {
    case loading
    case loaded
    case error(title: String, message: String)
}

protocol HomeViewModelType {
    var dataSource: HomeModelDataSource { get }
    
    // Inputs
    func perform(action: HomeViewAction)
    
    // Outputs
    var updateContent: ((HomeViewEffect) -> Void)? { get set }
    
}

final class HomeViewModel: HomeViewModelType {
    
    private let proccessDataQueue = DispatchQueue(label: "viewmodel.process.queue", qos: .userInitiated)
    private let apiClient: PolicyAPI
    private let policyPersistence: PolicyPersistence
    
    let dataSource = HomeModelDataSource()
    
    var updateContent: ((HomeViewEffect) -> Void)?
    
    init(apiClient: PolicyAPI, policyPersistence: PolicyPersistence) {
        self.apiClient = apiClient
        self.policyPersistence = policyPersistence
    }
    
    func perform(action: HomeViewAction) {
        switch action {
            case .viewLoaded, .reload:
                self.viewLoadedAction()
        }
    }
    
    private func updateContentOnMain(_ effect: HomeViewEffect) {
        DispatchQueue.main.async { [weak self] in
            self?.updateContent?(effect)
        }
    }
    
    private func viewLoadedAction() {
        updateContentOnMain(.loading)
        apiClient.getData(on: proccessDataQueue) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let data):
                    // save data and then proccess data to sections
                    self.policyPersistence.store(policyData: data)
                    self.convertStoredData()
                    break
                case .failure(let error):
                    if self.policyPersistence.hasStoredContent {
                        self.convertStoredData()
                    } else {
                        self.updateContentOnMain(.error(title: "Network Error",
                                                        message: error.errorDescription ?? error.localizedDescription))
                    }
                    break
            }
        }
    }
    
    private func convertStoredData() {
        let vehicles = self.policyPersistence.retrieveVehicles().map { Vehicle(value: $0) }
        let vehicleModels = vehicles.map { (vehicle) -> HomeSectionItem in
            return .vehicle(item: VehicleDisplayModel(vehicle: vehicle))
        }
        
        let activePolicies = policyPersistence.retrievePolicies().filter { $0.isActive() }
        let activePoliciesModels = activePolicies.map { policy -> HomeSectionItem in
            return .activeItem(item: ActivePolicyDisplayModel())
        }
        var data: [HomeSectionModel] = []
        if !activePolicies.isEmpty {
            data.append(.active(title: "Active policies", items: Array(activePoliciesModels)))
        }
        if !vehicleModels.isEmpty {
            data.append(.vehicles(title: "Vehicles", items: Array(vehicleModels)))
        }
        
        dataSource.update(data: data)
        updateContentOnMain(.loaded)
    }
    
}
