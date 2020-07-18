//
//  Created by Dimitrios Chatzieleftheriou on 18/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

class SeparatorReusableView: UICollectionReusableView {
    static let kind = "separator.view.kind"
    static let identifier = "separator.view.kind.id"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
