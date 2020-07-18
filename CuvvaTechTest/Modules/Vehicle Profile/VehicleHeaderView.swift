//
//  Created by Dimitrios Chatzieleftheriou on 18/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

class VehicleHeaderView: UIView {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DesignStyling.Colours.secondaryCTA
        return view
    }()
    
    lazy var carLogoBackground: UIView = {
        let view = UIView()
        view.backgroundColor = DesignStyling.Colours.white
        view.clipsToBounds = true
        return view
    }()
    
    lazy var carLogoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.borderColor = DesignStyling.Colours.white.cgColor
        return view
    }()
    
    private let carMakeAndRegView: TitleSubTitleView = {
        let view = TitleSubTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.font = DesignStyling.Fonts.headline
        view.titleLabel.textColor = DesignStyling.Colours.white
        view.titleLabel.numberOfLines = 1
        view.subtitleLabel.font = DesignStyling.Fonts.largeTitle
        view.subtitleLabel.textColor = DesignStyling.Colours.white
        view.titleLabel.numberOfLines = 1
        return view
    }()
    
    private let totalPolicies: TitleSubTitleView = {
        let view = TitleSubTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.font = DesignStyling.Fonts.subtitle
        view.titleLabel.textColor = DesignStyling.Colours.white
        view.titleLabel.numberOfLines = 1
        view.subtitleLabel.font = DesignStyling.Fonts.subtitle
        view.subtitleLabel.textColor = DesignStyling.Colours.white
        view.titleLabel.numberOfLines = 1
        return view
    }()
    
    private let extendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Extend cover", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(DesignStyling.Colours.titleDarkBlue, for: .highlighted)
        button.titleLabel?.font = DesignStyling.Fonts.title
        button.backgroundColor = DesignStyling.Colours.primaryCTA
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundView)
        
        carLogoBackground.addSubview(carLogoView)
        
        let stackView = UIStackView(arrangedSubviews: [carLogoBackground, carMakeAndRegView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        addSubview(stackView)
        
        addSubview(totalPolicies)
        addSubview(extendButton)
        
        NSLayoutConstraint.activate([
            carLogoBackground.widthAnchor.constraint(equalToConstant: 45),
            carLogoBackground.heightAnchor.constraint(equalToConstant: 45),
            carLogoView.topAnchor.constraint(equalTo: carLogoBackground.topAnchor, constant: 5),
            carLogoView.bottomAnchor.constraint(equalTo: carLogoBackground.bottomAnchor, constant: -5),
            carLogoView.leadingAnchor.constraint(equalTo: carLogoBackground.leadingAnchor, constant: 5),
            carLogoView.trailingAnchor.constraint(equalTo: carLogoBackground.trailingAnchor, constant: -5),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -15),
            totalPolicies.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            totalPolicies.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25),
            extendButton.topAnchor.constraint(equalTo: totalPolicies.bottomAnchor, constant: 5),
            extendButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            extendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            extendButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 0)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.layer.mask = backgroundView.makeBottomCurvedMask(offset: 20)
        carLogoBackground.layer.cornerRadius = 22.5 // cheating here, this is 45 * 0.5
    }
    
    func configure(item: VehicleDisplayModel) {
        
        self.carMakeAndRegView.update(title: item.carMakeTitle, subtitle: item.regPlateValueTitle)
        self.carLogoView.image = item.carMakeLogo
        self.totalPolicies.update(title: item.totalPoliciesTitle, subtitle: item.totalPoliciesValueTitle)
        
        layoutIfNeeded()
    }
    
}
