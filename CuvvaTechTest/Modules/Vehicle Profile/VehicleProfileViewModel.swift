//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum VehicleProfileViewAction {
    case viewLoaded
    case close
}

enum VehicleProfileViewEffect {
    case loading
    case loaded(vehicle: VehicleDisplayModel)
    case error(title: String, message: String)
}

protocol VehicleProfileViewModelType {
    var dataSource: SectionedModelDataSource<VehicleProfileSectionModel> { get }
    
    // Inputs
    func perform(action: VehicleProfileViewAction)
    
    // Outputs
    var updateContent: ((VehicleProfileViewEffect) -> Void)? { get set }
    var navigationTitle: String { get }
    
}

final class VehicleProfileViewModel: VehicleProfileViewModelType {
    let dataSource = SectionedModelDataSource<VehicleProfileSectionModel>()
    
    private let vehicleId: String
    private let policyPersistence: PolicyPersistence
    
    private let navigable: VehicleProfileNavigable
    
    var updateContent: ((VehicleProfileViewEffect) -> Void)?
    
    var navigationTitle: String {
        return "Vehicle profile"
    }
    
    init(persistence: PolicyPersistence, vehicleId: String, navigable: VehicleProfileNavigable) {
        self.policyPersistence = persistence
        self.vehicleId = vehicleId
        self.navigable = navigable
    }

    func perform(action: VehicleProfileViewAction) {
        switch action {
            case .viewLoaded:
                viewLoadedAction()
            case .close:
                navigable.closeVehicleProfile()
        }
    }
    
    private func viewLoadedAction() {
        
        guard let vehicle = policyPersistence.retrieveVehicles().first(where: { $0.vrm == vehicleId }) else {
            updateContent?(.error(title: "Error", message: "Couldn't find requested vehicle"))
            return
        }
        
        var data: [VehicleProfileSectionModel] = []
        if let activePoliciesForVehicle = vehicle.policies?.last(where: { $0.isActive() }) {
            let model = ActivePolicyDisplayModel(policy: activePoliciesForVehicle)
            let item = VehicleProfileSectionItem.activePolicy(item: model)
            data.append(.activePolicies(title: "Active driving policy", items: [item]))
        }
        
        let sortedPolcies = vehicle.policies?.sorted(by: { (left, right) -> Bool in
            guard let leftEndDate = left.endDate, let rightEndDate = right.endDate else {
                return false
            }
            return leftEndDate > rightEndDate
        })
        
        if let previousPolicies = sortedPolcies, !previousPolicies.isEmpty {
            let items = previousPolicies.map { VehicleProfileSectionItem.previousPolicy(item: PreviousPolicyDisplayModel(policy: $0)) }
            data.append(.previousPolicies(title: "Previous driving policies", items: Array(items)))
        }
        
        dataSource.update(data: data)
        
        updateContent?(.loaded(vehicle: VehicleDisplayModel(vehicle: vehicle, totalPolicies: vehicle.totalPolicies)))
        
    }

}
