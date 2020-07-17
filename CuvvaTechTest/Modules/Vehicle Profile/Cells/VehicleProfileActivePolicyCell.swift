//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

final class VehicleProfileActivePolicyCell: UICollectionViewCell {
    static let identifier = "vehicle.profile.active.cell.id"
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignStyling.Fonts.title
        label.textColor = DesignStyling.Colours.titleDarkBlue
        label.numberOfLines = 1
        return label
    }()
    
    private let countdownView: CircularCountdownView = {
        let view = CircularCountdownView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progressStrokeColor = DesignStyling.Colours.secondaryCTA
        view.backgroundStrokeColor = DesignStyling.Colours.grey
        view.progressLineWidth = 6
        return view
    }()
    private let policyRemaingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignStyling.Fonts.subtitle
        label.textColor = DesignStyling.Colours.titleDarkBlue
        label.numberOfLines = 1
        return label
    }()
    
    private let policyRemaingTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignStyling.Fonts.subtitle
        label.textColor = DesignStyling.Colours.secondaryCTA
        label.numberOfLines = 1
        return label
    }()
    
    private let policyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Policy", for: .normal)
        button.setTitleColor(DesignStyling.Colours.secondaryCTA, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private let getHelpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Help", for: .normal)
        button.setTitleColor(DesignStyling.Colours.warning, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
     
        let buttonsStackView = UIStackView(arrangedSubviews: [policyButton, getHelpButton])
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 5
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonsStackView)
        
    }
    
}
