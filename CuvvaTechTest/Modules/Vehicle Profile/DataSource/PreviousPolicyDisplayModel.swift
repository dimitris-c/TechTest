//
//  Created by Dimitrios Chatzieleftheriou on 18/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

struct PreviousPolicyDisplayModel: Equatable {
    let durationTitle: NSAttributedString
    let endDateTitle: String
    
    init(policy: Policy) {
        
        if let startDate = policy.startDate, let endDate = policy.endDate, !policy.isVoided {
            let duration = DateComponentsFormatter.countdownFormatterNoRemainingPhrase.string(from: startDate, to: endDate) ?? ""
            let attributedString = NSAttributedString(string: duration, attributes: [
                NSAttributedString.Key.foregroundColor: DesignStyling.Colours.titleDarkBlue,
                NSAttributedString.Key.font: DesignStyling.Fonts.headerTitle])
            durationTitle = attributedString
        } else if policy.isVoided {
            let attributedString = NSAttributedString(string: "Voided", attributes: [
                NSAttributedString.Key.foregroundColor: DesignStyling.Colours.alert,
                NSAttributedString.Key.font: DesignStyling.Fonts.headerTitle])
            durationTitle = attributedString
        } else {
            durationTitle = NSAttributedString(string: "n/a", attributes: [
                NSAttributedString.Key.foregroundColor: DesignStyling.Colours.titleDarkBlue,
                NSAttributedString.Key.font: DesignStyling.Fonts.headerTitle])
        }
        
        if let endDate = policy.endDate {
            endDateTitle = DateFormatter.dayDateMonthYear.string(from: endDate)
        } else {
            endDateTitle = "n/a"
        }
        
    }
}
