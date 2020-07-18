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
        label.font = DesignStyling.Fonts.headerTitle
        label.textColor = DesignStyling.Colours.titleDarkBlue
        label.numberOfLines = 1
        label.text = "Active Policy"
        label.textAlignment = .center
        return label
    }()
    
    private let countdownView: CircularCountdownView = {
        let view = CircularCountdownView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progressStrokeColor = DesignStyling.Colours.secondaryCTA
        view.backgroundStrokeColor = DesignStyling.Colours.grey
        view.progressLineWidth = 3
        return view
    }()
    
    private let countdownTitleAndSubtitle: TitleSubTitleView = {
        let view = TitleSubTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.font = DesignStyling.Fonts.headerTitle
        view.titleLabel.textColor = DesignStyling.Colours.titleDarkBlue
        view.subtitleLabel.font = DesignStyling.Fonts.subtitle
        view.subtitleLabel.textColor = DesignStyling.Colours.secondaryCTA
        return view
    }()

    private let policyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Policy", for: .normal)
        button.setTitleColor(DesignStyling.Colours.secondaryCTA, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.titleLabel?.font = DesignStyling.Fonts.title
        button.backgroundColor = DesignStyling.Colours.lightGray
        button.layer.cornerRadius = 4
        return button
    }()
    
    private let getHelpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Help", for: .normal)
        button.setTitleColor(DesignStyling.Colours.alert, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.titleLabel?.font = DesignStyling.Fonts.title
        button.backgroundColor = DesignStyling.Colours.lightGray
        button.layer.cornerRadius = 4
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
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
     
        let buttonsStackView = UIStackView(arrangedSubviews: [policyButton, getHelpButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 15
        contentView.addSubview(buttonsStackView)
        
        let countdownAndRemainingStackView = UIStackView(arrangedSubviews: [countdownView, countdownTitleAndSubtitle])
        countdownAndRemainingStackView.translatesAutoresizingMaskIntoConstraints = false
        countdownAndRemainingStackView.axis = .horizontal
        countdownAndRemainingStackView.alignment = .fill
        countdownAndRemainingStackView.distribution = .fill
        countdownAndRemainingStackView.spacing = 15
        contentView.addSubview(countdownAndRemainingStackView)
        contentView.addSubview(mainTitleLabel)
        
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            mainTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            mainTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            countdownAndRemainingStackView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 20),
            countdownAndRemainingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            countdownAndRemainingStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15),
            countdownView.widthAnchor.constraint(equalToConstant: 35),
            countdownView.widthAnchor.constraint(equalToConstant: 35),
            buttonsStackView.topAnchor.constraint(greaterThanOrEqualTo: countdownAndRemainingStackView.bottomAnchor, constant: 5),
            buttonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
        
    }
    
    func configure(item: ActivePolicyDisplayModel) {
        countdownTitleAndSubtitle.titleLabel.text = "Time remaining"
        countdownTitleAndSubtitle.subtitleLabel.text = item.formattedRemaingTimeTitle(displayRemainingPhrase: false)
        
        countdownView.duration = item.remainingSeconds
        countdownView.totalTime = Double(item.totalSeconds)
        
        countdownView.onUpdate = { [weak self] _ in
            self?.countdownTitleAndSubtitle.subtitleLabel.text = item.formattedRemaingTimeTitle(displayRemainingPhrase: false)
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
        countdownView.stop()
        countdownView.onUpdate = nil
    }
}
