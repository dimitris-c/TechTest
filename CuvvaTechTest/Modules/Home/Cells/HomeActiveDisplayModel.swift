//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

enum ActivePolicyDisplayModelAction: Equatable {
    case startVisualCountdown
    case stopVisualCountdown
}

enum ActivePolicyDisplayModelEffect: Equatable {
    case startCountdown
    case stopCountdown
}

final class ActivePolicyDisplayModel: Equatable {
    let carMakeTitle: String
    let carMakeSubtitle: String
    let carMakeLogo: UIImage?
    
    let regPlateTitle: String = "Reg Plate"
    let regPlateValueTitle: String
    
    var totalPoliciesTitle: String = "Total Policies"
    let totalPoliciesValueTitle: String
    
    private let policy: Policy
    
    var vehicleId: String {
        return policy.vehicle?.vrm ?? ""
    }
    
    var elapsedSeconds: TimeInterval {
        guard let startDate = policy.startDate else {
            return 0
        }
        
        return startDate.timeIntervalSince(Date())
    }
    
    var totalSeconds: TimeInterval {
        guard let endDate = policy.endDate, let startDate = policy.startDate else {
            return 0
        }
        return endDate.timeIntervalSince(startDate)
    }
    
    var remainingSeconds: TimeInterval {
        guard let endDate = policy.endDate else {
            return 0
        }
        return endDate.timeIntervalSince(Date())
    }
    
    var formattedRemaingTimeTitle: String? {
        return DateComponentsFormatter.countdownFormatter.string(from: Double(remainingSeconds))
    }
    
    var updateContent: ((ActivePolicyDisplayModelEffect) -> Void)?
    
    init(policy: Policy, totalPolicies: Int) {
        self.policy = policy
        if let vehicle = policy.vehicle {
            carMakeTitle = vehicle.make
            carMakeSubtitle = "\(vehicle.color) \(vehicle.model)"
            carMakeLogo = UIImage(named: "\(vehicle.make.lowercased())-logo")
            regPlateValueTitle = vehicle.prettyVrm
        } else {
            carMakeTitle = ""
            carMakeSubtitle = ""
            regPlateValueTitle = ""
            carMakeLogo = nil
        }
        
        totalPoliciesValueTitle = String(totalPolicies)
    }
    
    func perform(action: ActivePolicyDisplayModelAction) {
        switch action {
            case .startVisualCountdown:
                updateContent?(.startCountdown)
            case .stopVisualCountdown:
                updateContent?(.stopCountdown)
        }
    }

    static func == (lhs: ActivePolicyDisplayModel, rhs: ActivePolicyDisplayModel) -> Bool {
        return lhs.policy == rhs.policy
    }
}
