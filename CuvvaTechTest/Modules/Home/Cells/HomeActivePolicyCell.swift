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
    
    private let extendButton = UIButton()
    
    private let countdownView = CircularCountdownView()
    private let policyRemaingTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignStyling.Fonts.subtitle
        label.textColor = DesignStyling.Colours.secondaryCTA
        label.numberOfLines = 1
        return label
    }()
    
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
        
        extendButton.setTitle("Extend", for: .normal)
        extendButton.setTitleColor(.white, for: .normal)
        extendButton.setTitleColor(DesignStyling.Colours.titleDarkBlue, for: .highlighted)
        extendButton.titleLabel?.font = DesignStyling.Fonts.title
        extendButton.backgroundColor = DesignStyling.Colours.primaryCTA
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
        
        countdownView.translatesAutoresizingMaskIntoConstraints = false
        countdownView.progressStrokeColor = DesignStyling.Colours.secondaryCTA
        countdownView.backgroundStrokeColor = DesignStyling.Colours.grey
        countdownView.progressLineWidth = 2
        
        let countdownStackView = UIStackView(arrangedSubviews: [countdownView, policyRemaingTimeLabel])
        countdownStackView.translatesAutoresizingMaskIntoConstraints = false
        countdownStackView.axis = .horizontal
        countdownStackView.distribution = .fillProportionally
        countdownStackView.alignment = .center
        countdownStackView.spacing = 5
        contentView.addSubview(countdownStackView)
        
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
            countdownView.widthAnchor.constraint(equalToConstant: 15),
            countdownView.heightAnchor.constraint(equalToConstant: 15),
            countdownStackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            countdownStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
    }
    
    func configure(item: ActivePolicyDisplayModel) {
        self.carMakeAndTypeView.update(title: item.carMakeTitle, subtitle: item.carMakeSubtitle)
        self.logoView.image = item.carMakeLogo
        self.regPlateView.update(title: item.regPlateTitle, subtitle: item.regPlateValueTitle)
        self.totalPolicies.update(title: item.totalPoliciesTitle, subtitle: item.totalPoliciesValueTitle)
        
        policyRemaingTimeLabel.text = item.formattedRemaingTimeTitle
        countdownView.duration = item.remainingSeconds
        countdownView.totalTime = Double(item.totalSeconds)
        
        countdownView.onUpdate = { [policyRemaingTimeLabel] _ in
            policyRemaingTimeLabel.text = item.formattedRemaingTimeTitle
        }
        
        item.updateContent = { [weak self] effect in
            guard let self = self else { return }
            switch effect {
                case .startCountdown:
                    self.start()
                case .stopCountdown:
                    self.stop()
            }
        }
        
        item.perform(action: .startVisualCountdown)
        
        self.layoutIfNeeded()
    }
    
    private func start() {
        countdownView.start()
    }
    
    private func stop() {
        countdownView.stop()
        countdownView.onUpdate = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.carMakeAndTypeView.update(title: "", subtitle: "")
        self.regPlateView.update(title: "", subtitle: "")
        self.totalPolicies.update(title: "", subtitle: "")
        self.logoView.image = nil
        countdownView.stop()
        countdownView.onUpdate = nil
    }
}
