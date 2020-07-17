//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

final class HomeVehicleCell: UICollectionViewCell {
    static let identifier = "home.vehicle.cell.id"
    
    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.tintColor = DesignStyling.Colours.darkIndigo
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
    
    private let extendButton = UIButton(type: .custom)
    
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
        
        extendButton.setTitle("Insure", for: .normal)
        extendButton.setTitleColor(DesignStyling.Colours.secondaryCTA, for: .normal)
        extendButton.setTitleColor(DesignStyling.Colours.darkIndigo, for: .highlighted)
        extendButton.titleLabel?.font = DesignStyling.Fonts.title
        extendButton.backgroundColor = DesignStyling.Colours.viewsBackground
        extendButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        extendButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(extendButton)
        
        let stackView = UIStackView(arrangedSubviews: [logoView, carMakeAndTypeView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        contentView.addSubview(stackView)
        
        let bottomPartStackView = UIStackView(arrangedSubviews: [regPlateView, totalPolicies])
        bottomPartStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomPartStackView.axis = .horizontal
        bottomPartStackView.distribution = .fill
        bottomPartStackView.alignment = .fill
        bottomPartStackView.spacing = 35
        contentView.addSubview(bottomPartStackView)
        
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: 45),
            logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor),
            extendButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            extendButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            extendButton.widthAnchor.constraint(equalToConstant: 110),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: extendButton.leadingAnchor, constant: 0),
            bottomPartStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            bottomPartStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            bottomPartStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15),
        ])
        
    }
    
    func configure(item: VehicleDisplayModel) {
        
        self.carMakeAndTypeView.update(title: item.carMakeTitle, subtitle: item.carMakeSubtitle)
        self.logoView.image = item.carMakeLogo
        self.regPlateView.update(title: item.regPlateTitle, subtitle: item.regPlateValueTitle)
        self.totalPolicies.update(title: item.totalPoliciesTitle, subtitle: item.totalPoliciesValueTitle)
        
        self.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.carMakeAndTypeView.update(title: "", subtitle: "")
        self.regPlateView.update(title: "", subtitle: "")
        self.totalPolicies.update(title: "", subtitle: "")
        self.logoView.image = nil
    }
}
