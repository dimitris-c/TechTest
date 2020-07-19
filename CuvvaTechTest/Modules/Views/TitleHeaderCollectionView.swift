//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

final class TitleHeaderCollectionView: UICollectionReusableView {
    static let identifier = "title.header.collection.identifier"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
