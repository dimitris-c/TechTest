//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum HomeViewAction {
    case viewLoaded
    case reload
    case showvehicleProfile(_ indexPath: IndexPath)
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
    private let navigable: HomeNavigable
    
    let dataSource = HomeModelDataSource()
    
    var updateContent: ((HomeViewEffect) -> Void)?
    
    init(apiClient: PolicyAPI, policyPersistence: PolicyPersistence, navigable: HomeNavigable) {
        self.apiClient = apiClient
        self.policyPersistence = policyPersistence
        self.navigable = navigable
    }
    
    func perform(action: HomeViewAction) {
        switch action {
            case .viewLoaded, .reload:
                self.viewLoadedAction()
            case .showvehicleProfile(let indexPath):
                switch dataSource.model(at: indexPath) {
                    case .vehicle(let item):
                        self.navigable.presentVehicleProfile(with: item.vehicleId)
                    case .activeItem(let item):
                        self.navigable.presentVehicleProfile(with: item.vehicleId)
                    default:
                        break
                }
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
        let vehicles = self.policyPersistence.retrieveVehicles()
        let vehicleModels = vehicles.map { (vehicle) -> HomeSectionItem in
            let totalPolicies = vehicle.totalPolicies
            return .vehicle(item: VehicleDisplayModel(vehicle: Vehicle(value: vehicle), totalPolicies: totalPolicies))
        }
        
        let activePolicies = policyPersistence.retrievePolicies().filter { $0.isActive() }
        
        let activePoliciesModels = activePolicies.map { policy -> HomeSectionItem in
            let totalPolicies = policy.vehicle?.totalPolicies ?? 0
            let policyCopy = Policy(value: policy)
            if let vehicle = policyCopy.vehicle {
                policyCopy.vehicle = Vehicle(value: vehicle)
            }
            return .activeItem(item: ActivePolicyDisplayModel(policy: Policy(value: policyCopy), totalPolicies: totalPolicies))
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
