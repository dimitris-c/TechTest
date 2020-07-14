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
        
        static var body: UIFont {
            let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
                .addingAttributes([UIFontDescriptor.AttributeName.traits : fontTrait(with: .regular)])
            return UIFont(descriptor: fontDescriptor, size: 16)
        }
        
        static var footnote: UIFont {
            let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote)
                .addingAttributes([UIFontDescriptor.AttributeName.traits : fontTrait(with: .semibold)])
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
        
        static var title3: UIFont {
           let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title3)
               .addingAttributes([UIFontDescriptor.AttributeName.traits : fontTrait(with: .semibold)])
           return UIFont(descriptor: fontDescriptor, size: 20)
        }
    }
    
    struct Colours {
        static let primary = UIColor(red: 0.26, green: 0.26, blue: 0.77, alpha: 1.00)
        static let primaryCTA = UIColor(red: 0.08, green: 0.91, blue: 0.60, alpha: 1.00)
        static let secondaryCTA = UIColor(red: 0.36, green: 0.36, blue: 1.00, alpha: 1.00)
        static let darkIndigo = UIColor(red: 0.00, green: 0.02, blue: 0.55, alpha: 1.00)
        static let warning = UIColor(red: 1.00, green: 0.84, blue: 0.20, alpha: 1.00)
        static let alert = UIColor(red: 0.99, green: 0.17, blue: 0.18, alpha: 1.00)
        static let grey = UIColor(red: 0.56, green: 0.56, blue: 0.62, alpha: 1.00)
    }
    
}
