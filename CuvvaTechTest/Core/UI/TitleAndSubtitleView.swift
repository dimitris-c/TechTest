//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

final class TitleSubTitleView: UIStackView {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(subtitleLabel)
        self.axis = .vertical
        self.distribution = .fill
        self.alignment = .fill
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}
