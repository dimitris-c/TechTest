//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

struct DesignStyling {

    struct Fonts {
        private static func fontTrait(with weight: UIFont.Weight) -> [UIFontDescriptor.TraitKey: Any] {
            return [UIFontDescriptor.TraitKey.weight : weight]
        }
        
        static var title: UIFont {
            let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
                .addingAttributes([UIFontDescriptor.AttributeName.traits : fontTrait(with: .bold)])
            return UIFont(descriptor: fontDescriptor, size: 16)
        }
        
        static var subtitle: UIFont {
            let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote)
                .addingAttributes([UIFontDescriptor.AttributeName.traits : fontTrait(with: .regular)])
            return UIFont(descriptor: fontDescriptor, size: 13)
        }
        
        static var headline: UIFont {
            let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .headline)
                .addingAttributes([UIFontDescriptor.AttributeName.traits : fontTrait(with: .semibold)])
            return UIFont(descriptor: fontDescriptor, size: 17)
        }
        
        static var largeTitle: UIFont {
            let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
                .addingAttributes([UIFontDescriptor.AttributeName.traits : fontTrait(with: .bold)])
            return UIFont(descriptor: fontDescriptor, size: 30)
        }
        
        static var headerTitle: UIFont {
           let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title3)
               .addingAttributes([UIFontDescriptor.AttributeName.traits : fontTrait(with: .semibold)])
           return UIFont(descriptor: fontDescriptor, size: 13)
        }
    }
    
    struct Colours {
        static let primary = UIColor(red: 0.16, green: 0.10, blue: 0.55, alpha: 1.00)
        static let primaryCTA = UIColor(red: 0.11, green: 0.78, blue: 0.55, alpha: 1.00)
        static let secondaryCTA = UIColor(red: 0.35, green: 0.34, blue: 1.00, alpha: 1.00)
        static let darkIndigo = UIColor(red: 0.00, green: 0.02, blue: 0.55, alpha: 1.00)
        static let warning = UIColor(red: 1.00, green: 0.84, blue: 0.20, alpha: 1.00)
        static let alert = UIColor(red: 0.99, green: 0.17, blue: 0.18, alpha: 1.00)
        static let grey = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1.00)
        static let titleDarkBlue = UIColor(red: 0.09, green: 0.09, blue: 0.34, alpha: 1.00)
        static let subtitleLightBlue = UIColor(red: 0.37, green: 0.36, blue: 0.68, alpha: 1.00)
        static let viewsBackground = UIColor(red: 0.94, green: 0.93, blue: 1.00, alpha: 1.00)
    }
    
}
