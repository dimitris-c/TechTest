//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum HomeViewAction {
    case viewLoaded
}

enum HomeViewEffect {
    case loading
    case loaded
    case error(message: String)
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
            case .viewLoaded:
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
                    // check if there's data in persistence and display or error out
                    break
            }
        }
    }
    
    private func convertStoredData() {
        dataSource.update(data: [
            .active(title: "Active", items: [.activeItem(item: ActivePolicyDisplayModel())]),
            .vehicles(title: "Vehicles", items: [.vehicle(item: VehicleDisplayModel())]),
        ])
        updateContentOnMain(.loaded)
    }
    
}