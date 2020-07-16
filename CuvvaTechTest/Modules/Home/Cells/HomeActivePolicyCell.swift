//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

class HomeActivePolicyCell: UICollectionViewCell {
    static let identifier = "policy.active.cell.id"
    
    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let carMakeAndTypeView: TitleSubTitleView = {
        let view = TitleSubTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.font = DesignStyling.Fonts.title
        view.titleLabel.textColor = DesignStyling.Colours.titleDarkBlue
        view.titleLabel.numberOfLines = 1
        view.subtitleLabel.font = DesignStyling.Fonts.subtitle
        view.subtitleLabel.textColor = DesignStyling.Colours.subtitleLightBlue
        view.titleLabel.numberOfLines = 1
        return view
    }()
    
    private let regPlateView: TitleSubTitleView = {
        let view = TitleSubTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.font = DesignStyling.Fonts.subtitle
        view.titleLabel.textColor = DesignStyling.Colours.grey
        view.titleLabel.numberOfLines = 1
        view.subtitleLabel.font = DesignStyling.Fonts.subtitle
        view.subtitleLabel.textColor = DesignStyling.Colours.grey
        view.titleLabel.numberOfLines = 1
        return view
    }()
    
    private let totalPolicies: TitleSubTitleView = {
        let view = TitleSubTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.font = DesignStyling.Fonts.subtitle
        view.titleLabel.textColor = DesignStyling.Colours.grey
        view.titleLabel.numberOfLines = 1
        view.subtitleLabel.font = DesignStyling.Fonts.subtitle
        view.subtitleLabel.textColor = DesignStyling.Colours.grey
        view.titleLabel.numberOfLines = 1
        return view
    }()
    
    private let extendButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoView.layer.cornerRadius = logoView.bounds.width * 0.5
        extendButton.layer.cornerRadius = extendButton.bounds.height * 0.5
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        let stackView = UIStackView(arrangedSubviews: [logoView, carMakeAndTypeView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        contentView.addSubview(stackView)
        
        let bottomPartStackView = UIStackView(arrangedSubviews: [regPlateView, totalPolicies])
        bottomPartStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomPartStackView.axis = .horizontal
        bottomPartStackView.distribution = .fill
        bottomPartStackView.alignment = .fill
        bottomPartStackView.spacing = 10
        contentView.addSubview(bottomPartStackView)
        
        extendButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(extendButton)
        
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: 45),
            logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor),
            extendButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            extendButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            extendButton.heightAnchor.constraint(equalToConstant: 35),
            extendButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.topAnchor.constraint(equalTo: extendButton.topAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: extendButton.leadingAnchor, constant: 5),
            bottomPartStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            bottomPartStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            bottomPartStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15),
        ])
        
    }
    
}
