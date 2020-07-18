//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

class VehicleProfilePolicyCell: UICollectionViewCell {
    static let identifier = "vehicle.profile.policy.cell.id"
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignStyling.Fonts.title
        label.textColor = DesignStyling.Colours.titleDarkBlue
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignStyling.Fonts.titleSemibold
        label.textColor = DesignStyling.Colours.titleDarkBlue
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    private let chevronImageView = UIImageView(image: UIImage(named: "chevron"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = .white
        
        chevronImageView.tintColor = DesignStyling.Colours.grey
        
        let stackView = UIStackView(arrangedSubviews: [durationLabel, dateLabel, chevronImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.setCustomSpacing(10, after: dateLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(item: PreviousPolicyDisplayModel) {
        durationLabel.attributedText = item.durationTitle
        dateLabel.text = item.endDateTitle
    }
    
}
