//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

struct VehicleDisplayModel: Equatable {
    let carMakeTitle: String
    let carMakeSubtitle: String
    let carMakeLogo: UIImage?
    
    let regPlateTitle: String = "Reg Plate"
    let regPlateValueTitle: String
    
    var totalPoliciesTitle: String = "Total Policies"
    let totalPoliciesValueTitle: String
    
    let vehicleId: String
    
    let buttonAttributedTitleForNormalState: NSAttributedString
    let buttonAttributedTitleForHighlightedState: NSAttributedString
    
    let buttonBackgroundColor: UIColor
    
    init(vehicle: Vehicle, totalPolicies: Int) {
        self.vehicleId = vehicle.vrm
        self.carMakeTitle = vehicle.make
        self.carMakeSubtitle = "\(vehicle.color) \(vehicle.model)"
        self.carMakeLogo = UIImage(named: "\(vehicle.make.lowercased())-logo")
        self.regPlateValueTitle = vehicle.prettyVrm
        
        self.totalPoliciesValueTitle = String(totalPolicies)
        
        if vehicle.hasActivePolicy {
            self.buttonBackgroundColor = DesignStyling.Colours.primaryCTA
            self.buttonAttributedTitleForNormalState = NSAttributedString(string: "Extend cover", attributes: VehicleDisplayModel.attributesForExtendButton(highlighted: false))
            
            self.buttonAttributedTitleForHighlightedState = NSAttributedString(string: "Extend cover", attributes: VehicleDisplayModel.attributesForExtendButton(highlighted: true))
        } else {
            self.buttonBackgroundColor = DesignStyling.Colours.lightGray
            self.buttonAttributedTitleForNormalState = NSAttributedString(string: "Insure", attributes: VehicleDisplayModel.attributesForInsureButton(highlighted: false))
            
            self.buttonAttributedTitleForHighlightedState = NSAttributedString(string: "Insure", attributes: VehicleDisplayModel.attributesForInsureButton(highlighted: true))
        }
        
    }
    
    private static func attributesForInsureButton(highlighted: Bool) -> [NSAttributedString.Key: Any] {
        if highlighted {
            return [NSAttributedString.Key.foregroundColor: DesignStyling.Colours.darkIndigo,
                    NSAttributedString.Key.font: DesignStyling.Fonts.title]
        } else {
            return [NSAttributedString.Key.foregroundColor: DesignStyling.Colours.secondaryCTA,
                    NSAttributedString.Key.font: DesignStyling.Fonts.title]
        }
    }
    
    private static func attributesForExtendButton(highlighted: Bool) -> [NSAttributedString.Key: Any] {
        if highlighted {
            return [NSAttributedString.Key.foregroundColor: DesignStyling.Colours.white,
                    NSAttributedString.Key.font: DesignStyling.Fonts.title]
        } else {
            return [NSAttributedString.Key.foregroundColor: DesignStyling.Colours.white,
                    NSAttributedString.Key.font: DesignStyling.Fonts.title]
        }
    }
}
